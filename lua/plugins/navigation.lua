return {
    {
        url = 'https://codeberg.org/andyg/leap.nvim.git',
        name = 'leap.nvim',
        keys = {
            { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap forward to' },
            { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap backward to' },
            { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from windows' },
            { 'f', mode = { 'n', 'x', 'o' } },
            { 'F', mode = { 'n', 'x', 'o' } },
            { 't', mode = { 'n', 'x', 'o' } },
            { 'T', mode = { 'n', 'x', 'o' } },
        },
        opts = { labeled_modes = 'nx' },
        config = function(_, opts)
            local leap = require 'leap'
            for key, value in pairs(opts) do
                leap.opts[key] = value
            end
            leap.add_default_mappings(true)
            pcall(vim.keymap.del, { 'x', 'o' }, 'x')
            pcall(vim.keymap.del, { 'x', 'o' }, 'X')
        end,
    },
    { 'tpope/vim-repeat', event = 'VeryLazy' },
    { 'chrisgrieser/nvim-spider' },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            menu = {
                width = vim.api.nvim_win_get_width(0) - 4,
            },
            settings = {
                save_on_toggle = true,
            },
        },
    },
}
