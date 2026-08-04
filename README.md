# Neovim config

This is a fully custom Neovim config managed with `lazy.nvim`. It keeps a LazyVim-like workflow where that is useful, but the configuration is intentionally local, explicit, and split by responsibility.

## Requirements

- Neovim 0.12 or newer
- `git`, `make`, `unzip`, a C/C++ compiler
- `ripgrep` for grep pickers
- `fd` for the Snacks file picker
- `lazygit` for the Git TUI mappings
- `node`/`npm`, `go`, `rustup`, `zathura`, etc. as needed for the languages you use
- `codex` CLI for the Sidekick Codex integration
- A Nerd Font for icons

## Layout

- `init.lua` sets leaders, bootstraps plugins, and loads the core config modules.
- `lua/config/options.lua` contains editor options and clipboard behavior.
- `lua/config/keymaps.lua` contains global editor workflow maps and LSP attach maps.
- `lua/config/autocmds.lua` contains editor-wide autocmds such as format-on-save and yank highlight.
- `lua/config/lsp.lua` contains LSP server setup.
- `lua/plugins/*.lua` contains plugin specs, lazy-loading rules, plugin-local keymaps, and plugin options.
- `lua/util/*.lua` contains local helper functions shared by the config.

## Keymap Placement

Use `lua/config/keymaps.lua` for always-available editing workflows, mappings backed by already-loaded core plugins like Snacks, and buffer-local LSP maps created on `LspAttach`.

Use `keys = { ... }` inside a plugin spec when the key should lazy-load that plugin or only makes sense if that plugin is installed, command-gated, or filetype-gated. Which-key group names live in the `which-key.nvim` spec so groups stay named without dummy mappings.

## Plugin Manager

This config stays on `lazy.nvim` for now. Neovim 0.12 has native `vim.pack` support, but `:help vim.pack` still marks it experimental, and this repo relies heavily on lazy.nvim features: imports, lockfile behavior, event/filetype/command/key lazy-loading, build hooks, dependency wiring, and per-plugin opts.

A future switch to `vim.pack` would only make sense as a deliberate simplification pass. It would require replacing lazy-loading and build-hook behavior with local code, so it is not a free speed win for this config today.

## Remote Containers

For SSH/tmux/Apptainer sessions, prefer forwarding `TERM`, `COLORTERM`, locale variables, and either `SSH_TTY` or `NVIM_FORCE_OSC52=1` into the container. Set `NVIM_NO_OSC52=1` to disable the OSC52 clipboard override for a problematic terminal.

Tmux-aware pane navigation uses a local Neovim helper. When running Neovim inside Apptainer, the image needs a tmux client compatible with the host tmux server and the socket referenced by `$TMUX` must be visible inside the container.

If pane navigation works outside Apptainer but not inside it, run `:TmuxHealth` in Neovim. A typical fix is to pass `TMUX`, `TMUX_PANE`, and bind the socket directory, for example `--env TMUX="$TMUX" --env TMUX_PANE="$TMUX_PANE" --bind "$(dirname "${TMUX%%,*}")"`. If the image tmux client is incompatible with the host tmux server, expose a compatible client in the image and set `NVIM_TMUX_COMMAND` to it.

## Daily Keymaps

Leader is `<space>`.

| Key | Action |
| --- | --- |
| `<C-s>` | Save buffer |
| `<leader>bd` | Close buffer |
| `<leader>bD` | Close all other buffers |
| `<leader>qq` | Quit Neovim |
| `<leader>wq` | Close window |
| `<leader>e` | Toggle Mini.files at current file |
| `<leader>E` | Mini.files at cwd |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<C-h/j/k/l>` | Move between Neovim splits and tmux panes |
| `<C-Up/Down/Left/Right>` | Resize windows |
| `<leader>ff` / `<leader>fF` | Files from root / cwd |
| `<leader>fg` | Git files |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fo` | Recent files |
| `<leader>fp` | Projects |
| `<leader>fl` | Lines in current buffer |
| `<leader>fr` | Resume picker |
| `<leader>fk` | Keymaps |
| `<leader>fu` | Undo history |
| `<leader>f:` | Command history |
| `<leader>fC` | Colorschemes |
| `<leader>fs` / `<leader>fS` | Grep from root / cwd |
| `<leader>fB` | Grep open buffers |
| `<leader>fw` / `<leader>fW` | Grep word under cursor from root / cwd |
| `<leader>cf` / `<leader>cF` | Format buffer / injected languages |
| `<leader>ca` | Code action |
| `<leader>cr` / `<leader>cR` | Rename symbol / file |
| `<leader>cN` | Incremental rename |
| `<leader>ci` | LSP info |
| `<leader>cm` | Mason |
| `<leader>cs` / `<leader>cS` | Document / workspace symbols |
| `<leader>cx` / `<leader>cX` | Workspace / buffer diagnostics |
| `<leader>cd` | Line diagnostics float |
| `<leader>cq` | Diagnostic loclist |
| `<leader>gg` | Lazygit |
| `<leader>gf` | Lazygit current file history |
| `<leader>gl` | Lazygit log |
| `<leader>gd` | Diffview working tree |
| `<leader>gD` | Diffview against `HEAD` |
| `<leader>gh` / `<leader>gH` | Current file / repo history in Diffview |
| `<leader>gq` | Close Diffview |
| `<leader>p` | Yank history |
| `<C-p>` / `<C-n>` | Previous / next yank entry |
| `[y` / `]y` | Cycle yank entry |
| `<leader>h` / `<leader>H` | Harpoon menu / add file |
| `<leader>1` through `<leader>5` | Jump to Harpoon entry |
| `<leader>tt` | Toggle terminal |

## Plugin Reference

Full plugin documentation lives in [docs/plugins.md](docs/plugins.md).

## Format Commands

- `:FormatDisable`, `:FormatEnable`, and `:FormatToggle` control format-on-save for the current buffer.
- Add `!` to those commands to control format-on-save globally for the current session.
