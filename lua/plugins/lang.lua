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
                    vim.keymap.set('n', '<leader>cC', function()
                        vim.cmd.RustLsp 'codeAction'
                    end, { desc = 'Rust code action', buffer = bufnr })
                    vim.keymap.set('n', '<leader>dR', function()
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
        -- Vimtex installs its own ftplugin, syntax, and indent files, so it has to
        -- be on the runtimepath before the first tex buffer is created.
        lazy = false,
        init = function()
            -- Treat bare `.tex` files as LaTeX instead of plain TeX
            vim.g.tex_flavor = 'latex'

            -- Zathura reads SyncTeX, so forward search (`<localleader>lv`) and
            -- backward search (Ctrl+click in the PDF) both work. The full zathura
            -- backend locates the viewer window with xdotool, which is X11 only;
            -- `zathura_simple` instead lets zathura forward the sync to a running
            -- instance over D-Bus, which is what works on Wayland.
            vim.g.vimtex_view_method = vim.fn.executable 'xdotool' == 1 and 'zathura' or 'zathura_simple'
            vim.g.vimtex_view_forward_search_on_start = false

            -- Build with latexmk in continuous mode. `-shell-escape` is left out on
            -- purpose: it lets a document run arbitrary commands during compilation.
            vim.g.vimtex_compiler_method = 'latexmk'
            vim.g.vimtex_compiler_latexmk = {
                continuous = 1,
                options = {
                    '-verbose',
                    '-file-line-error',
                    '-synctex=1',
                    '-interaction=nonstopmode',
                },
            }

            -- Log parsing. pplatex gives much better messages when it is installed.
            vim.g.vimtex_quickfix_method = vim.fn.executable 'pplatex' == 1 and 'pplatex' or 'latexlog'
            vim.g.vimtex_quickfix_open_on_warning = 0
            vim.g.vimtex_quickfix_ignore_filters = {
                'Underfull \\\\hbox',
                'Overfull \\\\hbox',
                'Underfull \\\\vbox',
                'Overfull \\\\vbox',
                'Package hyperref Warning: Token not allowed in a PDF string',
                'Package typearea Warning: Bad type area settings!',
            }

            -- Conceal math, symbols, and styling so the source reads closer to the PDF.
            -- Requires `conceallevel=2`, which `config.autocmds` sets for tex buffers.
            vim.g.vimtex_syntax_conceal = {
                accents = 1,
                ligatures = 1,
                cites = 1,
                fancy = 1,
                greek = 1,
                math_bounds = 1,
                math_delimiters = 1,
                math_fracs = 1,
                math_super_sub = 1,
                math_symbols = 1,
                sections = 0,
                styles = 1,
            }

            -- Table of contents opens as a narrow left split
            vim.g.vimtex_toc_config = {
                split_pos = 'vert leftabove',
                split_width = 40,
                mode = 2,
                fold_enable = 1,
                hotkeys_enabled = 1,
                show_help = 0,
            }

            -- Editing helpers: keep `\begin`/`\end` in sync when changing an
            -- environment, don't align continuation lines on `&` in tables, and use
            -- vimtex's LaTeX-aware line breaking for `gq`.
            vim.g.vimtex_env_change_autofill = 1
            vim.g.vimtex_indent_on_ampersands = 0
            vim.g.vimtex_format_enabled = 1

            -- `K` stays on LSP hover; package docs live on `<leader>K`
            vim.g.vimtex_mappings_disable = { n = { 'K' } }
        end,
        keys = {
            { '<leader>K', '<plug>(vimtex-doc-package)', desc = 'Vimtex docs', ft = 'tex', silent = true },
        },
    },
}
