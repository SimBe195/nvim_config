-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if a Nerd Font is installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Install mini ]]
require 'mini_bootstrap'

-- [[ Setting options ]]
require 'options'

-- [[ Set up LSP ]]
require 'lsp'

-- [[ Various plugins ]]
require 'plugins'

-- [[ Commands that are run automatically upon certain events ]]
require 'autocmds'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
