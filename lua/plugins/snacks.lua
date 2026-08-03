return {
    {
        'folke/snacks.nvim',
        priority = 1000,
        opts = {
            animate = { enabled = true },
            bigfile = { enabled = true },
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
            dim = { enabled = true },
            explorer = { enabled = true },
            indent = {
                enabled = false,
                scope = { enabled = false },
            },
            input = { enabled = true },
            lazygit = { enabled = true },
            notifier = { enabled = true },
            picker = {
                enabled = true,
                win = {
                    input = {
                        keys = {
                            ['<a-c>'] = { 'toggle_cwd', mode = { 'n', 'i' } },
                        },
                    },
                },
                actions = {
                    toggle_cwd = function(picker)
                        local cwd = vim.fs.normalize(vim.uv.cwd() or '.')
                        local current = picker:cwd()
                        local root = vim.fs.root(picker.input.filter.current_buf, {
                            '.git',
                            'Cargo.toml',
                            'CMakeLists.txt',
                            'pyproject.toml',
                            'package.json',
                        }) or cwd
                        picker:set_cwd(current == root and cwd or root)
                        picker:find()
                    end,
                },
            },
            quickfile = { enabled = true },
            rename = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            toggle = { enabled = true },
            words = { enabled = true },
        },
    },
}
