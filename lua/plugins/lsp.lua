return {
    { 'neovim/nvim-lspconfig', dependencies = { 'saghen/blink.cmp' } },
    {
        'williamboman/mason-lspconfig.nvim', -- Bridge between Mason and nvim-lspconfig
        dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
        opts = {
            ensure_installed = {
                'lua_ls', -- Lua
                'basedpyright', -- Python
                'clangd', -- C++
                'rust_analyzer', -- Rust
                'julials', -- Julia
            },
            automatic_installation = true,
        },
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'black' },
                cmake = { 'cmake_format' },
                cpp = { 'clang_format' },
                rust = { 'rustfmt' },
                julia = { 'julia_formatter' },
            },
        },
    },
    {
        'zapling/mason-conform.nvim',
        dependencies = { 'stevearc/conform.nvim', 'williamboman/mason.nvim' },
        opts = {},
    },
    {
        'lervag/vimtex',
        lazy = false, -- we don't want to lazy load VimTeX
        init = function()
            vim.g.vimtex_view_method = 'zathura'
        end,
    },
}
