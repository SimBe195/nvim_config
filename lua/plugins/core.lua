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

local function normalize_path(path)
    local normalized = vim.fn.fnamemodify(vim.fn.expand(path), ':p')
    if normalized ~= '/' then
        normalized = normalized:gsub('/+$', '')
    end
    return normalized
end

local function slug(value)
    local normalized = value:lower():gsub('[^%w._-]+', '-'):gsub('^-+', ''):gsub('-+$', '')
    return normalized ~= '' and normalized or 'unknown'
end

local function python_tag()
    local python = vim.fn.exepath 'python3'
    if python == '' then
        return 'pyunknown'
    end

    local version = vim.fn.systemlist({ python, '--version' })[1] or ''
    local major, minor = version:match 'Python%s+(%d+)%.(%d+)'
    if major and minor then
        return 'py' .. major .. minor
    end
    return 'pyunknown'
end

local function container_name()
    for _, key in ipairs {
        'APPTAINER_CONTAINER',
        'SINGULARITY_CONTAINER',
        'APPTAINER_NAME',
        'SINGULARITY_NAME',
    } do
        local value = vim.env[key]
        if value and value ~= '' then
            return slug(value)
        end
    end
end

local function ensure_mason_tools(opts)
    local mason_bins = {
        [normalize_path(opts.install_root_dir) .. '/bin'] = true,
        [normalize_path(vim.fn.stdpath 'data' .. '/mason') .. '/bin'] = true,
    }
    if vim.env.MASON and vim.env.MASON ~= '' then
        mason_bins[normalize_path(vim.env.MASON) .. '/bin'] = true
    end

    local paths = vim.split(vim.env.PATH or '', ':', { plain = true })
    paths = vim.tbl_filter(function(path)
        return path == '' or not mason_bins[normalize_path(path)]
    end, paths)
    vim.env.PATH = table.concat(paths, ':')

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

local function mason_install_root()
    local root = vim.env.NVIM_MASON_ROOT
    if root and root ~= '' then
        return normalize_path(root)
    end

    local container = container_name()
    if container then
        return normalize_path(('%s/mason-containers/%s-%s'):format(vim.fn.stdpath 'data', container, python_tag()))
    end

    return normalize_path(vim.fn.stdpath 'data' .. '/mason')
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
            { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' },
        },
        opts = {
            install_root_dir = mason_install_root(),
            PATH = 'append',
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
