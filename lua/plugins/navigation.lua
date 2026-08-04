local leap_modes = { 'n', 'x', 'o' }

local function leap_clever_ft(kwargs, forward, backward)
    return function()
        local opts = require('leap.user').with_traversal_keys(forward, backward, {
            labels = '',
            safe_labels = vim.fn.mode(1):match 'no?' and '' or nil,
        })
        require('leap').leap(vim.tbl_deep_extend('keep', kwargs, {
            inputlen = 1,
            inclusive = true,
            opts = opts,
        }))
    end
end

return {
    {
        url = 'https://codeberg.org/andyg/leap.nvim.git',
        name = 'leap.nvim',
        keys = {
            { 's', '<Plug>(leap)', mode = leap_modes, desc = 'Leap' },
            { 'S', '<Plug>(leap-from-window)', mode = 'n', desc = 'Leap from window' },
            { 'gs', '<Plug>(leap-from-window)', mode = leap_modes, desc = 'Leap from window' },
            { 'f', leap_clever_ft({}, 'f', 'F'), mode = leap_modes, desc = 'Leap forward' },
            { 'F', leap_clever_ft({ backward = true }, 'f', 'F'), mode = leap_modes, desc = 'Leap backward' },
            { 't', leap_clever_ft({ offset = -1 }, 't', 'T'), mode = leap_modes, desc = 'Leap forward till' },
            {
                'T',
                leap_clever_ft({ backward = true, offset = 1 }, 't', 'T'),
                mode = leap_modes,
                desc = 'Leap backward till',
            },
        },
        opts = { labeled_modes = 'nx' },
        config = function(_, opts)
            local leap = require 'leap'
            for key, value in pairs(opts) do
                leap.opts[key] = value
            end
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
