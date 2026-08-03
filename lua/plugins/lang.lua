return {
    {
        'p00f/clangd_extensions.nvim',
        ft = { 'c', 'cpp', 'objc', 'objcpp' },
        opts = {
            inlay_hints = {
                inline = false,
            },
            ast = {
                role_icons = {
                    type = '',
                    declaration = '',
                    expression = '',
                    specifier = '',
                    statement = '',
                    ['template argument'] = '',
                },
                kind_icons = {
                    Compound = '',
                    Recovery = '',
                    TranslationUnit = '',
                    PackExpansion = '',
                    TemplateTypeParm = '',
                    TemplateTemplateParm = '',
                    TemplateParamObject = '',
                },
            },
        },
    },
    {
        'b0o/SchemaStore.nvim',
        lazy = true,
        version = false,
    },
    {
        'Saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        opts = {
            completion = {
                crates = {
                    enabled = true,
                },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
    {
        'mrcjkb/rustaceanvim',
        ft = { 'rust' },
        opts = {
            server = {
                on_attach = function(_, bufnr)
                    vim.keymap.set('n', '<leader>lA', function()
                        vim.cmd.RustLsp 'codeAction'
                    end, { desc = 'Rust code action', buffer = bufnr })
                    vim.keymap.set('n', '<leader>dr', function()
                        vim.cmd.RustLsp 'debuggables'
                    end, { desc = 'Rust debuggables', buffer = bufnr })
                end,
                default_settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            buildScripts = {
                                enable = true,
                            },
                        },
                        checkOnSave = true,
                        diagnostics = {
                            enable = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                        files = {
                            exclude = {
                                '.direnv',
                                '.git',
                                '.github',
                                '.gitlab',
                                '.jj',
                                'bin',
                                'node_modules',
                                'target',
                                'venv',
                                '.venv',
                            },
                            watcher = 'client',
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            local codelldb = vim.fn.exepath 'codelldb'
            local lib_ext = vim.uv.os_uname().sysname == 'Linux' and '.so' or '.dylib'
            local library_path = vim.fn.stdpath 'data' .. '/mason/opt/lldb/lib/liblldb' .. lib_ext
            if codelldb ~= '' and vim.uv.fs_stat(library_path) then
                opts.dap = {
                    adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb, library_path),
                }
            end
            vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
        end,
    },
    {
        'lervag/vimtex',
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_mappings_disable = { n = { 'K' } }
            vim.g.vimtex_quickfix_method = vim.fn.executable 'pplatex' == 1 and 'pplatex' or 'latexlog'
        end,
        keys = {
            { '<localLeader>l', '', desc = '+vimtex', ft = 'tex' },
        },
    },
}
