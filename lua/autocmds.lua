local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('__formatter__', { clear = true })

autocmd('BufWritePre', {
    pattern = '*',
    group = '__formatter__',
    callback = function(args)
        require('conform').format { bufnr = args.buf }
    end,
})
