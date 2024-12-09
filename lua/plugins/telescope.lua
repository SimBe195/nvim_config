now(function()
    add {
        source = 'nvim-telescope/telescope.nvim',
        depends = { 'nvim-lua/plenary.nvim' },
    }

    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ['<Cr>'] = 'select_default',
                },
                n = {
                    ['q'] = 'close',
                },
            },
        },
    }
end)
