return {
    {
        'neovim/nvim-lspconfig',
    },
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
}
