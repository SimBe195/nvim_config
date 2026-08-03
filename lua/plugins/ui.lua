local function get_attached_clients()
    local buf_clients = vim.lsp.get_clients { bufnr = 0 }
    if #buf_clients == 0 then
        return 'LSP Inactive'
    end

    local seen = {}
    local names = {}
    for _, client in ipairs(buf_clients) do
        if not seen[client.name] then
            seen[client.name] = true
            table.insert(names, client.name)
        end
    end

    return string.format('[%s]', table.concat(names, ', '))
end

return {
    { 'folke/todo-comments.nvim', event = 'BufReadPost', opts = {} },
    { 'nvim-tree/nvim-web-devicons', lazy = true, opts = {} },
    { 'nvim-mini/mini.icons', lazy = true, opts = {} },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = { 'MunifTanjim/nui.nvim' },
        opts = {
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
                lsp_doc_border = true,
            },
        },
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            flavour = 'mocha',
            transparent_background = false,
            integrations = {
                blink_cmp = true,
                harpoon = true,
                indent_blankline = {
                    enabled = true,
                    scope_color = '',
                    colored_indent_levels = false,
                },
                leap = true,
                mason = true,
                mini = {
                    enabled = true,
                    indentscope_color = '',
                },
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
                noice = true,
                snacks = true,
                treesitter = true,
                which_key = true,
            },
        },
        config = function(_, opts)
            require('catppuccin').setup(opts)
            vim.cmd.colorscheme 'catppuccin'
        end,
    },
    {
        'akinsho/bufferline.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
        config = function()
            local mocha = require('catppuccin.palettes').get_palette 'mocha'
            require('bufferline').setup {
                options = {
                    diagnostics = false,
                    separator_style = 'slant',
                    show_buffer_close_icons = true,
                    show_buffer_icons = true,
                    show_close_icon = true,
                    always_show_bufferline = true,
                },
                highlights = require('catppuccin.groups.integrations.bufferline').get {
                    styles = { 'italic', 'bold' },
                    custom = {
                        all = {
                            fill = { bg = mocha.crust },
                        },
                        mocha = {
                            background = { fg = mocha.surface2 },
                        },
                    },
                },
            }
        end,
    },
    {
        'nvim-mini/mini.diff',
        event = 'VeryLazy',
        keys = {
            {
                '<leader>go',
                function()
                    require('mini.diff').toggle_overlay(0)
                end,
                desc = 'Toggle mini.diff overlay',
            },
        },
        opts = {
            view = {
                style = 'sign',
                signs = {
                    add = '▎',
                    change = '▎',
                    delete = '',
                },
            },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        event = { 'VimEnter', 'BufReadPost', 'BufNewFile' },
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'catppuccin',
                    globalstatus = true,
                    component_separators = { left = '|', right = '|' },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = {
                        'branch',
                        {
                            'diff',
                            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
                            source = function()
                                local summary = vim.b.minidiff_summary
                                return summary
                                    and {
                                        added = summary.add,
                                        modified = summary.change,
                                        removed = summary.delete,
                                    }
                            end,
                        },
                        'diagnostics',
                    },
                    lualine_c = { { 'filetype', icon_only = true }, { 'filename', path = 1 } },
                    lualine_x = {
                        {
                            get_attached_clients,
                            color = { gui = 'bold' },
                        },
                    },
                    lualine_y = { 'progress' },
                    lualine_z = { { 'datetime', style = '%d. %h | %H:%M' } },
                },
            }
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        main = 'ibl',
        opts = {
            indent = {
                char = '│',
                tab_char = '│',
            },
            scope = { show_start = false, show_end = false },
            exclude = {
                filetypes = {
                    'help',
                    'lazy',
                    'mason',
                    'noice',
                    'notify',
                    'snacks_dashboard',
                    'snacks_notif',
                    'snacks_terminal',
                    'snacks_win',
                    'toggleterm',
                    'trouble',
                },
            },
        },
    },
    {
        'nvim-mini/mini.animate',
        event = 'VeryLazy',
        cond = vim.g.neovide == nil,
        opts = function(_, opts)
            local animate = require 'mini.animate'
            return vim.tbl_deep_extend('force', opts or {}, {
                resize = {
                    timing = animate.gen_timing.linear { duration = 50, unit = 'total' },
                },
                scroll = {
                    timing = animate.gen_timing.linear { duration = 150, unit = 'total' },
                },
            })
        end,
    },
    {
        'nvim-mini/mini.indentscope',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            symbol = '│',
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
                    'fzf',
                    'help',
                    'lazy',
                    'mason',
                    'noice',
                    'notify',
                    'sidekick_terminal',
                    'snacks_dashboard',
                    'snacks_notif',
                    'snacks_terminal',
                    'snacks_win',
                    'toggleterm',
                    'trouble',
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            mode = 'cursor',
            max_lines = 3,
        },
    },
    {
        'nvim-mini/mini.hipatterns',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = function()
            local hipatterns = require 'mini.hipatterns'
            return {
                highlighters = {
                    hex_color = hipatterns.gen_highlighter.hex_color { priority = 2000 },
                    shorthand = {
                        pattern = '()#%x%x%x()%f[^%x%w]',
                        group = function(_, _, data)
                            local match = data.full_match
                            if match == '#add' then
                                return
                            end
                            local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
                            return MiniHipatterns.compute_hex_color_group('#' .. r .. r .. g .. g .. b .. b, 'bg')
                        end,
                        extmark_opts = { priority = 2000 },
                    },
                },
            }
        end,
    },
    {
        'm00qek/baleia.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            local baleia = require('baleia').setup {}
            vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
                pattern = { 'log*', '*log' },
                callback = function(args)
                    baleia.once(args.buf)
                end,
            })
        end,
    },
}
