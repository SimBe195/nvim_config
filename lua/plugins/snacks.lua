return {
    {
        'folke/snacks.nvim',
        priority = 1000,
        opts = {
            animate = { enabled = true },
            bigfile = {
                enabled = true,
                setup = function(ctx)
                    if vim.fn.exists ':NoMatchParen' ~= 0 then
                        vim.cmd [[NoMatchParen]]
                    end

                    vim.opt_local.foldmethod = 'manual'
                    vim.opt_local.statuscolumn = ''
                    vim.opt_local.conceallevel = 0

                    vim.b[ctx.buf].autoformat = false
                    vim.b[ctx.buf].completion = false
                    vim.b[ctx.buf].minianimate_disable = true
                    vim.b[ctx.buf].minidiff_disable = true
                    vim.b[ctx.buf].minihipatterns_disable = true
                    vim.b[ctx.buf].miniindentscope_disable = true
                    vim.diagnostic.enable(false, { bufnr = ctx.buf })

                    vim.schedule(function()
                        if vim.api.nvim_buf_is_valid(ctx.buf) then
                            vim.bo[ctx.buf].syntax = ctx.ft
                        end
                    end)
                end,
            },
            dashboard = {
                enabled = true,
                sections = {
                    { section = 'header' },
                    { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
                    { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
                    { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
                    { section = 'startup' },
                },
            },
            dim = { enabled = true },
            explorer = { enabled = false },
            indent = {
                enabled = false,
                scope = { enabled = false },
            },
            input = { enabled = true },
            lazygit = { enabled = true },
            notifier = { enabled = true },
            picker = {
                enabled = true,
                win = {
                    input = {
                        keys = {
                            ['<a-c>'] = { 'toggle_cwd', mode = { 'n', 'i' } },
                        },
                    },
                },
                actions = {
                    toggle_cwd = function(picker)
                        local cwd = vim.fs.normalize(vim.uv.cwd() or '.')
                        local current = picker:cwd()
                        local root = require('util.root').get(picker.input.filter.current_buf) or cwd
                        picker:set_cwd(current == root and cwd or root)
                        picker:find()
                    end,
                },
            },
            quickfile = { enabled = true },
            rename = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            toggle = { enabled = true },
            words = { enabled = true },
        },
    },
}
