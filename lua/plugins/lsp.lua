local prettier_filetypes = {
    'css',
    'graphql',
    'handlebars',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'less',
    'markdown',
    'markdown.mdx',
    'scss',
    'typescript',
    'typescriptreact',
    'vue',
    'yaml',
}

local function conform_opts()
    local formatters_by_ft = {
        c = { 'clang-format' },
        cmake = { 'cmake_format' },
        cpp = { 'clang-format' },
        lua = { 'stylua' },
        python = { 'black' },
        rust = { 'rustfmt', lsp_format = 'fallback' },
        sh = { 'shfmt' },
        toml = { 'taplo' },
    }

    for _, ft in ipairs(prettier_filetypes) do
        formatters_by_ft[ft] = formatters_by_ft[ft] or {}
        table.insert(formatters_by_ft[ft], 'prettier')
    end

    formatters_by_ft.markdown = { 'prettier', 'markdownlint-cli2', 'markdown-toc' }
    formatters_by_ft['markdown.mdx'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' }

    return {
        default_format_opts = {
            timeout_ms = 3000,
            lsp_format = 'fallback',
        },
        formatters_by_ft = formatters_by_ft,
        formatters = {
            injected = { options = { ignore_errors = true } },
            ['markdown-toc'] = {
                condition = function(_, ctx)
                    for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                        if line:find '<!%-%- toc %-%->' then
                            return true
                        end
                    end
                end,
            },
            ['markdownlint-cli2'] = {
                condition = function(_, ctx)
                    local diag = vim.tbl_filter(function(diagnostic)
                        return diagnostic.source == 'markdownlint'
                    end, vim.diagnostic.get(ctx.buf))
                    return #diag > 0
                end,
            },
        },
    }
end

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
    },
    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
        },
    },
    {
        'stevearc/conform.nvim',
        cmd = 'ConformInfo',
        keys = {
            {
                '<leader>cF',
                function()
                    require('conform').format { formatters = { 'injected' }, timeout_ms = 3000 }
                end,
                mode = { 'n', 'x' },
                desc = 'Format injected langs',
            },
        },
        opts = conform_opts,
    },
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPost', 'BufWritePost', 'InsertLeave' },
        opts = {
            linters_by_ft = {
                cmake = { 'cmakelint' },
                markdown = { 'markdownlint-cli2' },
            },
        },
        config = function(_, opts)
            local lint = require 'lint'
            lint.linters_by_ft = opts.linters_by_ft

            vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
                group = vim.api.nvim_create_augroup('__lint__', { clear = true }),
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
