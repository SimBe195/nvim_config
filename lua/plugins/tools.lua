return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'Telescope',
        opts = {},
    },
    { 'kdheepak/lazygit.nvim' },
    {
        'folke/which-key.nvim',
        opts = {

            plugins = {
                spelling = {
                    enabled = true, -- Enable spelling hints
                    suggestions = 20, -- Number of suggestions to show
                },
            },
            key_labels = {
                ['<leader>'] = '<Space>',
                ['<Cr>'] = '↵',
                ['<Tab>'] = '⇆',
            },
            layout = {
                spacing = 6, -- Space between columns
                align = 'center',
            },
        },
    },
}
