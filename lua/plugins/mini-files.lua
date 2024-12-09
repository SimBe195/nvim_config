later(function()
    require('mini.files').setup {
        mappings = {
            close = 'q',
            go_in = '',
            go_in_plus = 'L',
            go_out = '',
            go_out_plus = 'H',
            mark_goto = "'",
            mark_set = 'm',
            reset = '<BS>',
            reveal_cwd = '@',
            show_help = 'g?',
            synchronize = '<Cr>',
            trim_left = '<',
            trim_right = '>',
        },
        windows = {
            preview = true,
        },
    }
end)
