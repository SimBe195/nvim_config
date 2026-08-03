return {
    {
        'saghen/blink.cmp',
        version = '1.*',
        dependencies = { 'rafamadriz/friendly-snippets' },
        event = 'InsertEnter',
        opts = {
            appearance = {
                nerd_font_variant = 'mono',
            },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                ghost_text = {
                    enabled = false,
                },
                menu = {
                    draw = {
                        treesitter = { 'lsp' },
                    },
                },
            },
            keymap = {
                preset = 'super-tab',
                ['<C-u>'] = { 'scroll_documentation_up' },
                ['<C-d>'] = { 'scroll_documentation_down' },
            },
            cmdline = {
                enabled = true,
                keymap = { preset = 'cmdline' },
                sources = { 'buffer', 'cmdline' },
            },
            term = {
                enabled = false,
                keymap = { preset = 'inherit' },
                sources = {},
            },
            signature = {
                enabled = true,
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
        opts_extend = { 'sources.default' },
    },
}
