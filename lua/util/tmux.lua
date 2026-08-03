local M = {}

local directions = {
    h = 'L',
    j = 'D',
    k = 'U',
    l = 'R',
    p = 'l',
}

local function tmux_socket()
    if vim.env.NVIM_TMUX_SOCKET and vim.env.NVIM_TMUX_SOCKET ~= '' then
        return vim.env.NVIM_TMUX_SOCKET
    end
    if not vim.env.TMUX or vim.env.TMUX == '' then
        return nil
    end
    return vim.split(vim.env.TMUX, ',', { plain = true })[1]
end

local function tmux_command()
    if vim.env.NVIM_TMUX_COMMAND and vim.env.NVIM_TMUX_COMMAND ~= '' then
        return vim.env.NVIM_TMUX_COMMAND
    end
    return vim.env.TMUX and vim.env.TMUX:find('tmate', 1, true) and 'tmate' or 'tmux'
end

local function command_args(...)
    local command = vim.split(tmux_command(), ' ', { trimempty = true })
    vim.list_extend(command, { ... })
    return command
end

function M.socket()
    return tmux_socket()
end

function M.command()
    return tmux_command()
end

function M.tmux(args)
    local socket = tmux_socket()
    if not socket or socket == '' then
        return nil, 'not inside tmux'
    end

    local command = command_args('-S', socket, unpack(args))
    local result = vim.system(command, { text = true }):wait()
    if result.code ~= 0 then
        return nil, vim.trim(result.stderr ~= '' and result.stderr or result.stdout or 'tmux command failed')
    end
    return result.stdout
end

function M.navigate(direction)
    if direction == 'p' then
        if vim.fn.winnr '$' > 1 then
            vim.cmd.wincmd 'p'
        else
            M.tmux { 'select-pane', '-t', vim.env.TMUX_PANE or '', '-l' }
        end
        return
    end

    local before = vim.api.nvim_get_current_win()
    pcall(vim.cmd.wincmd, direction)
    if vim.api.nvim_get_current_win() ~= before then
        return
    end

    local tmux_direction = directions[direction]
    if tmux_direction then
        M.tmux { 'select-pane', '-t', vim.env.TMUX_PANE or '', '-' .. tmux_direction }
    end
end

function M.health()
    local socket = tmux_socket()
    local lines = {}
    local ok = true

    local function check(label, condition, detail)
        ok = ok and condition
        table.insert(lines, ('%s %s%s'):format(condition and 'OK ' or 'BAD', label, detail and (': ' .. detail) or ''))
    end

    local command = tmux_command()
    local executable = vim.split(command, ' ', { trimempty = true })[1]

    check('$TMUX is set', vim.env.TMUX ~= nil and vim.env.TMUX ~= '', vim.env.TMUX)
    check('$TMUX_PANE is set', vim.env.TMUX_PANE ~= nil and vim.env.TMUX_PANE ~= '', vim.env.TMUX_PANE)
    check('tmux command is executable', vim.fn.executable(executable) == 1, command)

    if socket and socket ~= '' then
        check('tmux socket is visible', vim.uv.fs_stat(socket) ~= nil, socket)
    else
        check('tmux socket is visible', false)
    end

    if socket and socket ~= '' and vim.fn.executable(executable) == 1 then
        local version, err = M.tmux { 'display-message', '-p', '#{version}' }
        check('tmux server is reachable', version ~= nil, err or vim.trim(version or ''))
    end

    return ok, lines
end

return M
