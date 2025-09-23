return {
    {
        'folke/which-key.nvim',
        opts = {
            preset = 'helix',
            plugins = {
                spelling = {
                    enabled = true, -- Enable spelling hints
                    suggestions = 20, -- Number of suggestions to show
                },
            },
            replace = {
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
    {
        'nvim-mini/mini.files',
        opts = {
            mappings = {
                close = 'q',
                go_in = '',
                go_in_plus = 'l',
                go_out = '',
                go_out_plus = 'h',
                mark_goto = "'",
                mark_set = 'm',
                reset = '<Bs>',
                reveal_cwd = '@',
                show_help = 'g?',
                synchronize = '<C-s>',
                trim_left = '<',
                trim_right = '>',
            },
            windows = {
                preview = true,
                width_nofocus = 10,
                width_focus = 50,
                width_preview = 80,
            },
        },
    },
}
