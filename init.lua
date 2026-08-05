-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- nvim-treesitter's main branch requires the external tree-sitter CLI.
-- Some environments may not inherit Cargo's bin directory,
-- so expose a Cargo-installed CLI before plugins initialize.
local cargo_bin = vim.fs.joinpath(vim.env.HOME, '.cargo', 'bin')
if vim.uv.fs_stat(vim.fs.joinpath(cargo_bin, 'tree-sitter')) then
    local path = vim.split(vim.env.PATH or '', ':', { plain = true })
    if not vim.tbl_contains(path, cargo_bin) then
        vim.env.PATH = cargo_bin .. ':' .. (vim.env.PATH or '')
    end
end

-- Set to true if a Nerd Font is installed and selected in the terminal
vim.g.have_nerd_font = true

-- Load plugins using lazy.nvim
require 'lazy_bootstrap'

-- Load core configurations
require 'config.diagnostics'
require 'config.options'
require 'config.lsp'
require 'config.commands'
require 'config.keymaps'
require 'config.autocmds'

-- -- [[ Install mini ]]
-- require 'mini_bootstrap'
--
-- -- [[ Setting options ]]
-- require 'options'
--
-- -- [[ Set up LSP ]]
-- require 'lsp'
--
-- -- [[ Various plugins ]]
-- require 'plugins'

-- vim: ts=2 sts=2 sw=2 et
