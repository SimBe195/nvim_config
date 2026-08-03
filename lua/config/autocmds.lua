local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

autocmd('BufWritePre', {
    desc = 'Autoformat on save',
    pattern = '*',
    group = augroup '__formatter__',
    callback = function(args)
        if
            vim.g.autoformat == false
            or vim.b[args.buf].autoformat == false
            or vim.bo[args.buf].filetype == 'bigfile'
        then
            return
        end
        require('conform').format { async = false, lsp_format = 'fallback', bufnr = args.buf }
    end,
})

autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = augroup '__highlight_yank__',
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})

autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    desc = 'Reload files changed outside Neovim',
    group = augroup '__checktime__',
    callback = function()
        if vim.bo.buftype ~= 'nofile' then
            vim.cmd.checktime()
        end
    end,
})

augroup '__filetypes__'

autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.config',
    command = 'set filetype=ini',
    group = '__filetypes__',
})

autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = 'returnn.config',
    command = 'set filetype=python',
    group = '__filetypes__',
})

autocmd('FileType', {
    group = '__filetypes__',
    pattern = { 'gitcommit', 'markdown', 'markdown.mdx', 'tex', 'text' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
    end,
})

autocmd('FileType', {
    desc = 'Use q to close temporary buffers',
    group = '__filetypes__',
    pattern = {
        'checkhealth',
        'dap-float',
        'help',
        'lazy',
        'lspinfo',
        'man',
        'mason',
        'noice',
        'notify',
        'qf',
        'query',
        'snacks_notif',
        'snacks_win',
        'startuptime',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true, desc = 'Close window' })
    end,
})

autocmd('BufReadPost', {
    desc = 'Go to last loc when opening a buffer',
    callback = function(event)
        local exclude = { 'gitcommit' }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
    group = augroup '__last_loc__',
})

autocmd({ 'BufWritePre' }, {
    desc = 'Auto create dir when saving a file, in case some intermediate directory does not exist',
    group = augroup '__auto_create_dir__',
    callback = function(event)
        if event.match:match '^%w%w+:[\\/][\\/]' then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
})
