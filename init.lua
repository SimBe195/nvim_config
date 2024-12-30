-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if a Nerd Font is installed and selected in the terminal
vim.g.have_nerd_font = true

-- Load plugins using lazy.nvim
require 'lazy_bootstrap'

-- Load core configurations
require 'config.options'
require 'config.lsp'
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
