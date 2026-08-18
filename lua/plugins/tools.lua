local function current_file_or_root()
    local file = vim.api.nvim_buf_get_name(0)
    return file ~= '' and file or require('util.root').get()
end

local function mini_files(path)
    return function()
        require('mini.files').open(path(), true)
    end
end

local function mini_files_toggle(path)
    return function()
        local mini = require 'mini.files'
        if mini.close() == nil then
            mini.open(path(), true)
        end
    end
end

return {
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            preset = 'helix',
            spec = {
                { '<leader>a', group = 'ai', mode = { 'n', 'x' } },
                { '<leader>b', group = 'buffers' },
                { '<leader>c', group = 'code', mode = { 'n', 'x' } },
                { '<leader>d', group = 'debug' },
                { '<leader>dp', group = 'python debug' },
                { '<leader>f', group = 'find', mode = { 'n', 'x' } },
                { '<leader>g', group = 'git' },
                { '<leader>m', group = 'markdown' },
                { '<leader>q', group = 'quit' },
                { '<leader>r', group = 'refactor', mode = { 'n', 'x' } },
                { '<leader>s', group = 'session' },
                { '<leader>t', group = 'terminal' },
                { '<leader>w', group = 'windows' },
                { '<localleader>l', group = 'vimtex' },
            },
            plugins = {
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
            },
            replace = {
                ['<leader>'] = '<Space>',
                ['<Cr>'] = '↵',
                ['<Tab>'] = '⇆',
            },
            layout = {
                spacing = 6,
                align = 'center',
            },
        },
    },
    {
        'nvim-mini/mini.files',
        keys = {
            { '<leader>e', mini_files_toggle(current_file_or_root), desc = 'Toggle explorer current file' },
            {
                '<leader>E',
                mini_files(function()
                    return vim.uv.cwd()
                end),
                desc = 'Explorer cwd',
            },
        },
        opts = {
            mappings = {
                close = 'q',
                go_in = '',
                go_in_plus = 'l',
                go_out = '',
                go_out_plus = 'h',
                mark_goto = "'",
                mark_set = 'm',
                reset = '<Bs>',
                reveal_cwd = '@',
                show_help = 'g?',
                synchronize = '<C-s>',
                trim_left = '<',
                trim_right = '>',
            },
            windows = {
                preview = true,
                width_nofocus = 10,
                width_focus = 50,
                width_preview = 80,
            },
        },
        config = function(_, opts)
            local mini = require 'mini.files'
            mini.setup(opts)
            local group = vim.api.nvim_create_augroup('__mini_files__', { clear = true })

            local show_dotfiles = true
            local filter_show = function()
                return true
            end
            local filter_hide = function(fs_entry)
                return not vim.startswith(fs_entry.name, '.')
            end

            local function toggle_dotfiles()
                show_dotfiles = not show_dotfiles
                mini.refresh {
                    content = { filter = show_dotfiles and filter_show or filter_hide },
                }
            end

            local function map_split(buf_id, lhs, direction, close_on_file)
                vim.keymap.set('n', lhs, function()
                    local new_target_window
                    local cur_target_window = mini.get_explorer_state().target_window
                    if cur_target_window ~= nil then
                        vim.api.nvim_win_call(cur_target_window, function()
                            vim.cmd('belowright ' .. direction .. ' split')
                            new_target_window = vim.api.nvim_get_current_win()
                        end)

                        mini.set_target_window(new_target_window)
                        mini.go_in { close_on_file = close_on_file }
                    end
                end, { buffer = buf_id, desc = 'Open in ' .. direction .. ' split' })
            end

            vim.api.nvim_create_autocmd('User', {
                group = group,
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    local buf_id = args.data.buf_id
                    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle hidden files' })
                    vim.keymap.set('n', 'gc', function()
                        local entry = mini.get_fs_entry()
                        local directory = entry and vim.fs.dirname(entry.path)
                        if directory then
                            vim.fn.chdir(directory)
                        end
                    end, { buffer = buf_id, desc = 'Set cwd' })

                    map_split(buf_id, '<C-w>s', 'horizontal', false)
                    map_split(buf_id, '<C-w>v', 'vertical', false)
                    map_split(buf_id, '<C-w>S', 'horizontal', true)
                    map_split(buf_id, '<C-w>V', 'vertical', true)
                end,
            })

            vim.api.nvim_create_autocmd('User', {
                group = group,
                pattern = 'MiniFilesActionRename',
                callback = function(event)
                    Snacks.rename.on_rename_file(event.data.from, event.data.to)
                end,
            })
        end,
    },
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        opts = {
            direction = 'float',
            open_mapping = [[<leader>tt]],
            float_opts = {
                border = 'curved',
            },
        },
    },
    {
        'ahmedkhalf/project.nvim',
        event = 'VeryLazy',
        opts = {
            manual_mode = true,
        },
        config = function(_, opts)
            require('project_nvim').setup(opts)
        end,
    },
    {
        'folke/persistence.nvim',
        event = 'BufReadPre',
        opts = {},
        keys = {
            {
                '<leader>ss',
                function()
                    require('persistence').load()
                end,
                desc = 'Restore session (cwd)',
            },
            {
                '<leader>sl',
                function()
                    require('persistence').load { last = true }
                end,
                desc = 'Restore last session',
            },
            {
                '<leader>sd',
                function()
                    require('persistence').stop()
                end,
                desc = "Don't save current session",
            },
        },
    },
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = function()
            require('lazy').load { plugins = { 'markdown-preview.nvim' } }
            vim.fn['mkdp#util#install']()
        end,
        keys = {
            { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Markdown preview', ft = 'markdown' },
        },
        config = function()
            vim.cmd [[do FileType]]
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown', 'markdown.mdx', 'norg', 'rmd', 'org' },
        opts = {
            code = {
                sign = false,
                width = 'block',
                right_pad = 1,
            },
            heading = {
                sign = false,
                icons = {},
            },
            checkbox = {
                enabled = false,
            },
        },
    },
    {
        'linux-cultist/venv-selector.nvim',
        cmd = 'VenvSelect',
        ft = 'python',
        opts = {
            options = {
                notify_user_on_venv_activation = true,
                override_notify = false,
            },
        },
        keys = {
            { '<leader>cv', '<cmd>VenvSelect<cr>', desc = 'Select virtualenv', ft = 'python' },
        },
    },
}
