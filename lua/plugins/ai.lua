return {
    {
        'folke/sidekick.nvim',
        opts = {
            cli = {
                tools = {
                    codex = {
                        cmd = { 'codex', '--sandbox', 'danger-full-access' },
                    },
                },
            },
        },
        keys = {
            { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
            {
                '<c-.>',
                function()
                    require('sidekick.cli').focus()
                end,
                desc = 'Sidekick focus',
                mode = { 'n', 't', 'i', 'x' },
            },
            {
                '<leader>aa',
                function()
                    require('sidekick.cli').toggle()
                end,
                desc = 'Sidekick toggle CLI',
            },
            {
                '<leader>as',
                function()
                    require('sidekick.cli').select()
                end,
                desc = 'Select CLI',
            },
            {
                '<leader>ad',
                function()
                    require('sidekick.cli').close()
                end,
                desc = 'Detach CLI session',
            },
            {
                '<leader>at',
                function()
                    require('sidekick.cli').send { msg = '{this}' }
                end,
                mode = { 'x', 'n' },
                desc = 'Send this',
            },
            {
                '<leader>af',
                function()
                    require('sidekick.cli').send { msg = '{file}' }
                end,
                desc = 'Send file',
            },
            {
                '<leader>av',
                function()
                    require('sidekick.cli').send { msg = '{selection}' }
                end,
                mode = 'x',
                desc = 'Send visual selection',
            },
            {
                '<leader>ap',
                function()
                    require('sidekick.cli').prompt()
                end,
                mode = { 'n', 'x' },
                desc = 'Sidekick select prompt',
            },
        },
    },
    {
        'supermaven-inc/supermaven-nvim',
        event = 'InsertEnter',
        cmd = {
            'SupermavenUseFree',
            'SupermavenUsePro',
        },
        opts = {
            keymaps = {
                accept_suggestion = nil,
            },
            disable_inline_completion = vim.g.ai_cmp,
            ignore_filetypes = { 'bigfile', 'snacks_input', 'snacks_notif' },
        },
    },
}
