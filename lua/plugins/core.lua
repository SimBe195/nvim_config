local function unique(list)
    local seen = {}
    local ret = {}
    for _, value in ipairs(list) do
        if not seen[value] then
            seen[value] = true
            table.insert(ret, value)
        end
    end
    return ret
end

local function ensure_mason_tools(opts)
    require('mason').setup(opts)

    local registry = require 'mason-registry'
    registry:on('package:install:success', function()
        vim.defer_fn(function()
            require('lazy.core.handler.event').trigger {
                event = 'FileType',
                buf = vim.api.nvim_get_current_buf(),
            }
        end, 100)
    end)

    registry.refresh(function()
        if #vim.api.nvim_list_uis() == 0 then
            return
        end
        for _, tool in ipairs(opts.ensure_installed or {}) do
            local ok, package = pcall(registry.get_package, tool)
            if ok and not package:is_installed() then
                package:install()
            end
        end
    end)
end

return {
    { 'folke/lazy.nvim' },
    { 'nvim-lua/plenary.nvim', lazy = true },
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate',
        lazy = false,
        opts = {
            ensure_installed = unique {
                'bash',
                'bibtex',
                'c',
                'cmake',
                'cpp',
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitcommit',
                'gitignore',
                'json',
                'json5',
                'julia',
                'latex',
                'lua',
                'markdown',
                'markdown_inline',
                'ninja',
                'python',
                'ron',
                'rst',
                'rust',
                'toml',
                'vim',
                'vimdoc',
            },
        },
        config = function(_, opts)
            local xdg_config = vim.env.XDG_CONFIG_HOME or (vim.env.HOME .. '/.config')
            local function have(path)
                return vim.uv.fs_stat(xdg_config .. '/' .. path) ~= nil
            end

            vim.filetype.add {
                extension = {
                    mdx = 'markdown.mdx',
                    rasi = 'rasi',
                    rofi = 'rasi',
                    wofi = 'rasi',
                },
                filename = {
                    vifmrc = 'vim',
                },
                pattern = {
                    ['.*/hypr/.+%.conf'] = 'hyprlang',
                    ['.*/kitty/.+%.conf'] = 'kitty',
                    ['.*/mako/config'] = 'dosini',
                    ['.*/waybar/config'] = 'jsonc',
                    ['%.env%.[%w_.-]+'] = 'sh',
                },
            }
            vim.treesitter.language.register('bash', 'kitty')

            local parsers = opts.ensure_installed
            if type(parsers) == 'table' then
                if have 'hypr' then
                    table.insert(parsers, 'hyprlang')
                end
                if have 'fish' then
                    table.insert(parsers, 'fish')
                end
                if have 'rofi' or have 'wofi' then
                    table.insert(parsers, 'rasi')
                end
                opts.ensure_installed = unique(parsers)
            end

            require('nvim-treesitter').setup {
                install_dir = opts.install_dir,
            }

            if type(opts.ensure_installed) == 'table' and #vim.api.nvim_list_uis() > 0 then
                require('nvim-treesitter').install(opts.ensure_installed)
            end

            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('__treesitter__', { clear = true }),
                callback = function(args)
                    if vim.bo[args.buf].filetype == 'bigfile' then
                        return
                    end

                    local ok = pcall(vim.treesitter.start, args.buf)
                    if ok then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },
    {
        'mason-org/mason.nvim',
        cmd = 'Mason',
        build = ':MasonUpdate',
        keys = {
            { '<leader>lm', '<cmd>Mason<cr>', desc = 'Mason' },
        },
        opts = {
            ensure_installed = {
                'black',
                'clang-format',
                'cmakelang',
                'cmakelint',
                'codelldb',
                'debugpy',
                'markdown-toc',
                'markdownlint-cli2',
                'prettier',
                'shellcheck',
                'shfmt',
                'stylua',
            },
        },
        config = function(_, opts)
            ensure_mason_tools(opts)
        end,
    },
}
