local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

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
