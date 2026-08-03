return {
    {
        'max397574/better-escape.nvim',
        event = 'InsertEnter',
        opts = {
            default_mappings = false,
            mappings = {
                i = { j = { k = '<Esc>' } },
                c = { j = { k = '<Esc>' } },
            },
        },
    },
    {
        'nvim-mini/mini.pairs',
        event = 'InsertEnter',
        opts = {},
    },
    {
        'gbprod/yanky.nvim',
        event = 'BufReadPost',
        keys = {
            {
                '<Leader>p',
                function()
                    ---@diagnostic disable-next-line: undefined-field
                    Snacks.picker.yanky()
                end,
                mode = { 'n', 'x' },
                desc = 'Yank history',
            },
            { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put after cursor' },
            { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put before cursor' },
            { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put after selection' },
            { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put before selection' },
            { '<C-p>', '<Plug>(YankyPreviousEntry)', desc = 'Previous yank entry' },
            { '<C-n>', '<Plug>(YankyNextEntry)', desc = 'Next yank entry' },
            { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle yank forward' },
            { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle yank backward' },
        },
        opts = {
            system_clipboard = {
                sync_with_ring = not vim.env.SSH_CONNECTION,
            },
            highlight = { on_yank = false, on_put = true, timer = 150 },
        },
    },
    {
        'nvim-mini/mini.ai',
        event = 'VeryLazy',
        opts = function()
            local ai = require 'mini.ai'
            return {
                n_lines = 500,
                mappings = {
                    around = 'a',
                    inside = 'i',
                    around_next = 'an',
                    inside_next = 'in',
                    around_last = 'ap',
                    inside_last = 'ip',
                    goto_left = 'g[',
                    goto_right = 'g]',
                },
                custom_textobjects = {
                    o = ai.gen_spec.treesitter {
                        a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                        i = { '@block.inner', '@conditional.inner', '@loop.inner' },
                    },
                    f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
                    c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
                },
            }
        end,
    },
    {
        'nvim-mini/mini.comment',
        event = 'VeryLazy',
        dependencies = {
            {
                'JoosepAlviste/nvim-ts-context-commentstring',
                lazy = true,
                opts = { enable_autocmd = false },
            },
        },
        opts = {
            options = {
                custom_commentstring = function()
                    return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
                end,
            },
        },
    },
    {
        'nvim-mini/mini.surround',
        event = 'VeryLazy',
        opts = {
            mappings = {
                add = 'ysa',
                delete = 'ysd',
                replace = 'ysr',
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
    {
        'nvim-mini/mini.move',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'smjonas/inc-rename.nvim',
        cmd = 'IncRename',
        opts = {},
    },
    { 'lewis6991/async.nvim', lazy = true },
    {
        'ThePrimeagen/refactoring.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {},
        keys = {
            {
                '<leader>rs',
                function()
                    return require('refactoring').select_refactor()
                end,
                mode = { 'n', 'x' },
                desc = 'Select refactor',
            },
            {
                '<leader>ri',
                function()
                    return require('refactoring').inline_var()
                end,
                mode = { 'n', 'x' },
                desc = 'Inline variable',
                expr = true,
            },
            {
                '<leader>rP',
                function()
                    return require('refactoring.debug').print_loc { output_location = 'below' }
                end,
                desc = 'Debug print location',
                expr = true,
            },
            {
                '<leader>rp',
                function()
                    return require('refactoring.debug').print_var { output_location = 'below' } .. 'iw'
                end,
                mode = { 'n', 'x' },
                desc = 'Debug print variable',
                expr = true,
            },
            {
                '<leader>rc',
                function()
                    return require('refactoring.debug').cleanup { restore_view = true } .. 'ag'
                end,
                desc = 'Debug cleanup',
                expr = true,
            },
            {
                '<leader>rf',
                function()
                    return require('refactoring').extract_func()
                end,
                mode = { 'n', 'x' },
                desc = 'Extract function',
                expr = true,
            },
            {
                '<leader>rF',
                function()
                    return require('refactoring').extract_func_to_file()
                end,
                mode = { 'n', 'x' },
                desc = 'Extract function to file',
                expr = true,
            },
            {
                '<leader>rx',
                function()
                    return require('refactoring').extract_var()
                end,
                mode = { 'n', 'x' },
                desc = 'Extract variable',
                expr = true,
            },
        },
    },
}
