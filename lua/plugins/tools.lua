return {
    {
        'ibhagwan/fzf-lua',
        cmd = 'FzfLua',
        opts = function()
            local actions = require('fzf-lua').actions
            return {
                'default-title',
                fzf_colors = true,
                fzf_opts = {
                    ['--no-scrollbar'] = true,
                },
                defaults = {
                    formatter = 'path.dirname_first',
                },
                files = {
                    cwd_prompt = false,
                    actions = {
                        ['alt-i'] = { actions.toggle_ignore },
                        ['alt-h'] = { actions.toggle_hidden },
                    },
                },
                grep = {
                    actions = {
                        ['alt-i'] = { actions.toggle_ignore },
                        ['alt-h'] = { actions.toggle_hidden },
                    },
                },
                winopts = {
                    width = 0.8,
                    height = 0.8,
                    row = 0.5,
                    col = 0.5,
                    preview = {
                        scrollchars = { '┃', '' },
                    },
                },
            }
        end,
        config = function(_, opts)
            if opts[1] == 'default-title' then
                local function fix(table_)
                    table_.prompt = table_.prompt ~= nil and ' ' or nil
                    for _, value in pairs(table_) do
                        if type(value) == 'table' then
                            fix(value)
                        end
                    end
                    return table_
                end
                opts = vim.tbl_deep_extend('force', fix(require('fzf-lua.profiles.default-title')), opts)
                opts[1] = nil
            end
            require('fzf-lua').setup(opts)
            require('fzf-lua').register_ui_select()
        end,
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            preset = 'helix',
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
            require('mini.files').setup(opts)

            local show_dotfiles = true
            local filter_show = function()
                return true
            end
            local filter_hide = function(fs_entry)
                return not vim.startswith(fs_entry.name, '.')
            end

            local function toggle_dotfiles()
                show_dotfiles = not show_dotfiles
                require('mini.files').refresh {
                    content = { filter = show_dotfiles and filter_show or filter_hide },
                }
            end

            local function map_split(buf_id, lhs, direction, close_on_file)
                vim.keymap.set('n', lhs, function()
                    local new_target_window
                    local cur_target_window = require('mini.files').get_explorer_state().target_window
                    if cur_target_window ~= nil then
                        vim.api.nvim_win_call(cur_target_window, function()
                            vim.cmd('belowright ' .. direction .. ' split')
                            new_target_window = vim.api.nvim_get_current_win()
                        end)

                        require('mini.files').set_target_window(new_target_window)
                        require('mini.files').go_in { close_on_file = close_on_file }
                    end
                end, { buffer = buf_id, desc = 'Open in ' .. direction .. ' split' })
            end

            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    local buf_id = args.data.buf_id
                    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle hidden files' })
                    vim.keymap.set('n', 'gc', function()
                        local entry = MiniFiles.get_fs_entry()
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
        'Civitasv/cmake-tools.nvim',
        lazy = true,
        init = function()
            local loaded = false
            local function check()
                local cwd = vim.uv.cwd()
                if cwd and vim.fn.filereadable(cwd .. '/CMakeLists.txt') == 1 then
                    require('lazy').load { plugins = { 'cmake-tools.nvim' } }
                    loaded = true
                end
            end
            check()
            vim.api.nvim_create_autocmd('DirChanged', {
                callback = function()
                    if not loaded then
                        check()
                    end
                end,
            })
        end,
        opts = {},
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
            { '<leader>lv', '<cmd>VenvSelect<cr>', desc = 'Select virtualenv', ft = 'python' },
        },
    },
}
