return {
    {
        'hrsh7th/nvim-cmp', -- Autocompletion plugin
        enabled = false,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', -- LSP completions
            'hrsh7th/cmp-buffer', -- Buffer completions
            'hrsh7th/cmp-path', -- File path completions
            'hrsh7th/cmp-cmdline', -- Command-line completions
            'L3MON4D3/LuaSnip', -- Snippet engine
            'saadparwaiz1/cmp_luasnip', -- Snippet completions
            'rafamadriz/friendly-snippets', -- Predefined snippets
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'

            -- Load snippets
            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
                    ['<Tab>'] = cmp.mapping.confirm { select = true }, -- Accept completion
                    ['<C-n>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-p>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = cmp.config.sources {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
            }

            -- Use buffer source for '/' (search).
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                },
            })

            -- Use cmdline & path source for ':' (command line).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    { name = 'cmdline' },
                }),
            })
        end,
    },
    {
        'saghen/blink.cmp',
        version = '*',
        dependencies = { 'rafamadriz/friendly-snippets' },
        event = 'InsertEnter',
        opts = {
            appearance = { nerd_font_variant = 'mono' },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    draw = {
                        treesitter = { 'lsp' },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                ghost_text = {
                    enabled = true,
                },
            },
            signature = {
                enabled = true,
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                cmdline = {},
            },
            keymap = {
                preset = 'super-tab',
                ['<C-u>'] = { 'scroll_documentation_up' },
                ['<C-d>'] = { 'scroll_documentation_down' },
            },
        },
        opts_extend = { 'sources.default' },
    },
}
