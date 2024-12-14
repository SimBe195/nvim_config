return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'Telescope',
        opts = {},
    },
    { 'kdheepak/lazygit.nvim' },
    {
        'akinsho/toggleterm.nvim',
        opts = {

            open_mapping = '<F7>',
            direction = 'float',
            border = 'shadow',
            title_pos = 'center',
        },
    },
}
