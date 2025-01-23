-- Returns a string with a list of attached LSP clients, including
-- formatters and linters from null-ls, nvim-lint and formatter.nvim

local function get_attached_clients()
    local buf_clients = vim.lsp.get_clients { bufnr = 0 }
    if #buf_clients == 0 then
        return 'LSP Inactive'
    end

    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
        table.insert(buf_client_names, client.name)
    end

    -- This needs to be a string only table so we can use concat below
    local unique_client_names = {}
    for _, client_name_target in ipairs(buf_client_names) do
        local is_duplicate = false
        for _, client_name_compare in ipairs(unique_client_names) do
            if client_name_target == client_name_compare then
                is_duplicate = true
            end
        end
        if not is_duplicate then
            table.insert(unique_client_names, client_name_target)
        end
    end

    local client_names_str = table.concat(unique_client_names, ', ')
    local language_servers = string.format('[%s]', client_names_str)

    return language_servers
end

return {
    { 'folke/todo-comments.nvim', opts = {} },
    { 'nvim-tree/nvim-web-devicons', opts = {} },
    {
        'folke/noice.nvim',
        dependencies = { 'MunifTanjim/nui.nvim' },
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        },
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        opts = {
            flavour = 'mocha',
            transparent_background = false,
            integrations = {
                blink_cmp = true,
                dashboard = true,
                mason = true,
                cmp = true,
                harpoon = true,
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
                nvim_surround = true,
                leap = true,
                indent_blankline = {
                    enabled = true,
                    scope_color = '',
                    colored_indent_levels = false,
                },
                lsp_saga = true,
                treesitter = true,
                telescope = {
                    enabled = true,
                    -- style = 'nvchad',
                },
                noice = true,
                mini = {
                    enabled = true,
                    indentscope_color = '',
                },
                snacks = true,
                which_key = true,
                -- For more plugins integrations see https://github.com/catppuccin/nvim#integrations
            },
        },
        config = function(_, opts)
            require('catppuccin').setup(opts)
            vim.cmd.colorscheme 'catppuccin'
        end,
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
        config = function()
            local mocha = require('catppuccin.palettes').get_palette 'mocha'
            require('bufferline').setup {
                options = {
                    numbers = 'none', -- Set to "ordinal" or "buffer_id" if you want numbers
                    diagnostics = false, -- Show LSP diagnostics in the tabline
                    separator_style = 'slant', -- Options: "slant", "thick", "thin", etc.
                    show_close_icon = true,
                    show_buffer_close_icons = true,
                    show_buffer_icons = true,
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
                        latte = {
                            background = { fg = '#000000' },
                        },
                    },
                },
            }
        end,
    },
    {
        'echasnovski/mini.diff',
        event = 'VeryLazy',
        opts = {
            view = {
                style = 'sign',
                signs = {
                    add = '▎',
                    change = '▎',
                    delete = '',
                },
                diff_color = {
                    added = { fg = '#98be65' },
                    modified = { fg = '#FF8800' },
                    removed = { fg = '#ec5f67' },
                },
            },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        event = { 'VimEnter', 'BufReadPost', 'BufNewFile' },
        config = function()
            local attached_clients = {
                get_attached_clients,
                color = {
                    gui = 'bold',
                },
            }
            -- Example lualine setup
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
                    lualine_x = { attached_clients },
                    lualine_y = { 'progress' },
                    lualine_z = { { 'datetime', style = '%d. %h | %H:%M' } },
                },
            }
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
    },
}
