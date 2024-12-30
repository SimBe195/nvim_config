return {
    {
        'folke/snacks.nvim',
        lazy = false,
        opts = {
            -- Animations for several actions
            animate = { enabled = true },
            -- Automatically disable LSP and treesitter for files larger than 1.5MB
            bigfile = { enabled = true },
            -- Nice looking dashboard when starting nvim
            dashboard = {
                enabled = true,
                sections = {
                    { section = 'header' },
                    { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
                    { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
                    { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
                    { section = 'startup' },
                },
            },
            -- Focus on the active scope by dimming the rest
            dim = { enabled = true },
            -- Automatically configure lazygit with the right theme and integrate edit with neovim instance
            lazygit = { enabled = true },
            -- Pretty vim.notify
            notifier = { enabled = true },
            -- Scope detection based on treesitter or indent, introduces `ii`, `ai`, `]i` and `[i` keymaps to select/jump scopes
            scope = { enabled = true },
            -- Smooth scrolling
            scroll = { enabled = true },
            -- Pretty status column
            statuscolumn = { enabled = true },
        },
    },
}
