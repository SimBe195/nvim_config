now(function()
    add {
        source = 'nvim-telescope/telescope.nvim',
        depends = { 'nvim-lua/plenary.nvim' },
    }

    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ['<C-y>'] = 'select_default',
                },
                n = {
                    ['q'] = 'close',
                    ['<C-p>'] = 'move_selection_previous',
                    ['<C-n>'] = 'move_selection_next',
                    ['<C-y>'] = 'select_default',
                },
            },
        },
    }
end)
