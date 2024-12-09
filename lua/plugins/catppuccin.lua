now(function()
    add {
        source = 'catppuccin/nvim',
        name = 'catppuccin',
    }
    require('catppuccin').setup {
        flavout = 'mocha',
        transparent_background = true,
        integrations = {
            dashboard = true,
            mason = true,
            cmp = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { 'italic' },
                    hints = { 'italic' },
                    warnings = { 'italic' },
                    information = { 'italic' },
                    ok = { 'italic' },
                },
                underlines = {
                    errors = { 'underline' },
                    hints = { 'underline' },
                    warnings = { 'underline' },
                    information = { 'underline' },
                    ok = { 'underline' },
                },
                inlay_hints = {
                    background = true,
                },
            },
            treesitter = true,
            telescope = {
                enabled = true,
                style = 'nvchad',
            },
            notify = false,
            mini = {
                enabled = true,
                indentscope_color = '',
            },
            -- For more plugins integrations see https://github.com/catppuccin/nvim#integrations
        },
    }

    vim.cmd.colorscheme 'catppuccin'
end)
