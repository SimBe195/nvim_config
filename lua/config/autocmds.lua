local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

autocmd('BufWritePre', {
    desc = 'Autoformat on save',
    pattern = '*',
    group = augroup '__formatter__',
    callback = function(args)
        require('conform').format { async = false, lsp_fallback = true, bufnr = args.buf }
    end,
})

autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = augroup '__highlight_yank__',
    callback = function()
        (vim.hl or vim.highlight).on_yank()
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

autocmd('User', {
    pattern = 'MiniFilesActionRename',
    group = augroup '__file_rename__',
    callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
})
