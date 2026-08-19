# Plugin Reference

This file documents the plugins configured in `lua/plugins/*.lua`, what each one is responsible for, and the keymaps this config wires to it.

| Plugin | What it does | Configured keymaps |
| --- | --- | --- |
| `lazy.nvim` | Plugin manager. It loads plugin specs from `lua/plugins` and keeps `lazy-lock.json` pinned. | `:Lazy` command |
| `snacks.nvim` | Core UI/workflow plugin for dashboard, picker, bigfile handling, lazygit, notifications, rename support, statuscolumn, and more. It is the configured fuzzy picker/search surface; its explorer module is disabled because `mini.files` owns file management. | `<leader>f*`, `<leader>c{s,S,x,X}`, `<leader>gg`, `<leader>gf`, `<leader>gl`, `<leader>p` |
| `which-key.nvim` | Shows available keymaps as you type and names the top-level groups. Group declarations are centralized in `lua/plugins/tools.lua`. | No direct command map; opens automatically |
| `mini.files` | Edit-as-buffer file manager for creating, deleting, renaming, moving, and synchronizing filesystem changes. It is the primary explorer. | `<leader>e`, `<leader>E`; inside mini.files: `l`, `h`, `q`, `g.`, `gc`, `<C-s>`, `<C-w>s`, `<C-w>v`, `<C-w>S`, `<C-w>V` |
| `catppuccin` | Colorscheme and integration colors for the rest of the UI. | None |
| `nvim-web-devicons` | Filetype icons for UI plugins. | None |
| `mini.icons` | Icon provider used by which-key and other plugins. | None |
| `noice.nvim` | Replaces selected command-line, message, and LSP documentation UI with nicer popups and routes. | None |
| `nui.nvim` | UI dependency for Noice. | None |
| `bufferline.nvim` | Buffer tabline with Catppuccin styling. | `<S-h>`, `<S-l>` navigate buffers globally |
| `lualine.nvim` | Statusline with branch, diff, diagnostics, LSP clients, progress, and time. | None |
| `todo-comments.nvim` | Highlights TODO/FIXME-style comments. | None |
| `indent-blankline.nvim` | Draws indentation guides, excluding big files and special buffers. | None |
| `mini.indentscope` | Shows the current indentation scope. It is disabled for big files and special UI buffers. | None |
| `mini.animate` | Adds short resize animations. Scroll animation is disabled to keep jumps and mouse-wheel scrolling responsive. It is disabled entirely in Neovide and for big files. | None |
| `mini.hipatterns` | Highlights hex colors and shorthand hex colors in buffers. | None |
| `mini.diff` | Provides lightweight Git signs and the diff summary used by lualine. The overlay mapping was removed in favor of Diffview. | None |
| `diffview.nvim` | Opens side-by-side Git diffs and file history views. This is the primary readable diff workflow. | `<leader>gd`, `<leader>gD`, `<leader>gh`, `<leader>gH`, `<leader>gq` |
| `baleia.nvim` | Colorizes ANSI escape sequences in log buffers, except buffers detected as big files. | None |
| `nvim-treesitter` | Installs parsers and enables Treesitter highlighting, indentation, and folding helpers. It skips highlighting and indentation for `bigfile` buffers. | None |
| `nvim-treesitter-context` | Shows sticky semantic context at the top of code windows. | None |
| `nvim-lspconfig` | Configures built-in LSP clients. LSP maps are attached buffer-locally when a server starts. | `K`, `gK`, `gd`, `gD`, `gi`, `gy`, `gr`, `<leader>ca`, `<leader>cr`, `<leader>cR`, `<leader>ci`, `<leader>cN`, clangd-only `<leader>ch` |
| `mason.nvim` | Installs external tools such as formatters, linters, LSP servers, and DAP adapters. | `<leader>cm` |
| `mason-lspconfig.nvim` | Bridges Mason-installed LSP servers into Neovim LSP setup. | None |
| `mason-nvim-dap.nvim` | Installs debug adapters through Mason. | None |
| `conform.nvim` | Formatting engine for format-on-save and manual formatting. Big files opt out of autoformat. | `<leader>cf`, `<leader>cF`; `:FormatDisable`, `:FormatEnable`, `:FormatToggle` |
| `nvim-lint` | Runs configured linters for CMake and Markdown after writes and insert leave. | None |
| `blink.cmp` | Completion engine for LSP, path, snippets, buffer, and cmdline sources. | Insert/cmdline completion uses the `super-tab` preset; `<C-u>` and `<C-d>` scroll docs |
| `friendly-snippets` | Snippet collection consumed by `blink.cmp`. | None |
| `better-escape.nvim` | Lets `jk` leave insert and command mode. | `jk` in insert/command mode |
| `mini.pairs` | Auto-pairs brackets and quotes while typing. | None |
| `yanky.nvim` | Maintains yank history and improves put/cycle behavior. Plain `y` is native again to avoid extra lag. | `p`, `P`, `gp`, `gP`, `<leader>p`, `<C-p>`, `<C-n>`, `[y`, `]y` |
| `mini.ai` | Extra text objects, including Treesitter-aware functions/classes/blocks. | `a`/`i` text objects, `an`, `in`, `ap`, `ip`, `g[`, `g]` |
| `mini.comment` | Comment toggling with Treesitter-aware comment strings. | `gc` / `gcc` default comment mappings |
| `nvim-ts-context-commentstring` | Supplies the correct comment string for embedded languages. | None |
| `mini.surround` | Add, delete, and replace surrounding delimiters. | `ysa`, `ysd`, `ysr` |
| `mini.move` | Move lines or visual selections around. | Default `<M-h/j/k/l>` move mappings |
| `inc-rename.nvim` | Incremental rename command used by the LSP map. | `<leader>cN` |
| `refactoring.nvim` | Refactoring actions and debug print helpers. | `<leader>rs`, `<leader>ri`, `<leader>rP`, `<leader>rp`, `<leader>rc`, `<leader>rf`, `<leader>rF`, `<leader>rx` |
| `leap.nvim` | Fast jump motions, including enhanced `f`, `F`, `t`, and `T`. | `s`, `S`, `gs`, `f`, `F`, `t`, `T` |
| `vim-repeat` | Makes supported plugin actions repeatable with `.`. | `.` where supported |
| `nvim-spider` | Smarter subword-aware `w`, `e`, and `b` motions. | `w`, `e`, `b` |
| `harpoon` | Quick file marking and jumping. | `<leader>h`, `<leader>H`, `<leader>1` through `<leader>5`, `<C-S-P>`, `<C-S-N>` |
| `toggleterm.nvim` | Floating terminal integration. | `<leader>tt` |
| `project.nvim` | Project root detection used by project-aware pickers. | `<leader>fp` through Snacks projects |
| `markdown-preview.nvim` | Browser-based Markdown preview. | `<leader>mp` in Markdown |
| `render-markdown.nvim` | In-editor Markdown rendering for headings and code blocks. | None |
| `venv-selector.nvim` | Select and activate Python virtual environments. | `<leader>cv` in Python |
| `clangd_extensions.nvim` | Extra clangd features for C and C++. | clangd-only `<leader>ch` |
| `SchemaStore.nvim` | JSON schema catalog for `jsonls`. | None |
| `crates.nvim` | Cargo.toml crate completion, hover, and actions. | None |
| `rustaceanvim` | Rust LSP and DAP integration. | Rust buffers: `<leader>cC`, `<leader>dR` |
| `vimtex` | LaTeX editing, compilation, viewing, and docs. | `<leader>K` for package docs; Vimtex also provides its own localleader maps |
| `nvim-dap` | Debug adapter protocol core and general debug controls. | `<leader>dB`, `<leader>db`, `<leader>dc`, `<leader>da`, `<leader>dC`, `<leader>dg`, `<leader>di`, `<leader>dj`, `<leader>dk`, `<leader>dl`, `<leader>do`, `<leader>dO`, `<leader>dP`, `<leader>dr`, `<leader>ds`, `<leader>dt`, `<leader>dw` |
| `nvim-dap-ui` | Debugger side panels and eval UI. | `<leader>du`, `<leader>de` |
| `nvim-dap-virtual-text` | Inline virtual text for debugger values. | None |
| `nvim-dap-python` | Python DAP adapter integration and test debugging helpers. | `<leader>dpm`, `<leader>dpc` in Python |
| `nvim-nio` | Async dependency for DAP UI. | None |
| `sidekick.nvim` | AI CLI integration, configured to run Codex with danger-full-access sandbox. Sidekick chat uses the normal editor background to avoid an off-color side pane. | `<C-.>`, `<leader>aa`, `<leader>as`, `<leader>ad`, `<leader>at`, `<leader>af`, visual `<leader>av`, `<leader>ap` |
| `supermaven-nvim` | AI completion provider. Inline accept is disabled so completion stays under the configured completion flow. | None |
| `async.nvim` | Async helper dependency. | None |
| `plenary.nvim` | Lua utility dependency used by multiple plugins. | None |
