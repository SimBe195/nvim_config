return {
    {
        'max397574/better-escape.nvim',
        opts = {
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
                t = {
                    j = {
                        k = '<C-\\><C-n>',
                    },
                },
                v = {},
                s = {},
            },
        },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {},
    },
    {
        'gbprod/yanky.nvim',
        opts = {},
    },
    {
        'echasnovski/mini.ai',
        opts = {
            mappings = {
                -- Main textobject prefixes
                around = 'a',
                inside = 'i',

                -- Next/last variants
                around_next = 'an',
                inside_next = 'in',
                around_last = 'ap',
                inside_last = 'ip',

                -- Move cursor to corresponding edge of `a` textobject
                goto_left = 'g[',
                goto_right = 'g]',
            },
        },
    },
    {
        'matze/vim-move',
    },
    {
        'tpope/vim-surround',
    },
}
