local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('__formatter__', { clear = true })

autocmd('BufWritePre', {
    desc = 'Autoformat on save',
    pattern = '*',
    group = '__formatter__',
    callback = function(args)
        require('conform').format { async = false, lsp_fallback = true, bufnr = args.buf }
    end,
})

autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
