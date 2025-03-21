return {
    {
        'max397574/better-escape.nvim',
        opts = {
            default_mappings = false,
            mappings = {
                i = {
                    j = {
                        k = '<Esc>',
                    },
                },
                c = {
                    j = {
                        k = '<Esc>',
                    },
                },
            },
        },
    },
    {
        {
            'saghen/blink.cmp',
            opts = {
                keymap = {
                    preset = 'super-tab',
                    ['<C-u>'] = { 'scroll_documentation_up' },
                    ['<C-d>'] = { 'scroll_documentation_down' },
                },
            },
        },
    },
}
