return {
    { 'folke/lazy.nvim' },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = 'BufReadPost',
        opts = {
            ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'markdown', 'python', 'rust', 'julia' },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false, -- Use only Treesitter highlighting
            },
            indent = { enable = true },
        },
    },
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        opts = {},
    },
}
