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
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },
    { 'gbprod/yanky.nvim', opts = {} },
    {
        'echasnovski/mini.ai',
        event = 'VeryLazy',
        opts = function()
            local ai = require 'mini.ai'
            return {
                n_lines = 500,
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
                custom_textobjects = {
                    o = ai.gen_spec.treesitter { -- code block
                        a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                        i = { '@block.inner', '@conditional.inner', '@loop.inner' },
                    },
                    f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
                    c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' }, -- class
                },
            }
        end,
    },
    { 'matze/vim-move' },
    {
        'echasnovski/mini.surround',
        opts = {
            mappings = {
                add = 'ysa', -- Add surrounding in Normal and Visual modes
                delete = 'ysd', -- Delete surrounding
                replace = 'ysr', -- Replace surrounding
                find = '',
                find_left = '',
                highlight = '',
                update_n_lines = '',
                suffix_last = 'p',
                suffix_next = 'n',
            },
            n_lines = 50,
        },
    },
}
