-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Easier exiting into normal mode
vim.keymap.set('i', 'jk', '<Esc>')

vim.keymap.set('n', '<leader>w', '<Cmd>w<CR>', { desc = 'Save buffer' })
vim.keymap.set('n', '<leader>c', '<Cmd>bdelete<CR>', { desc = 'Close buffer' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- Exit terminal mode in the builtin terminal.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<Space><Space>', function()
  MiniFiles.open()
end, { desc = 'Open file explorer' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keybinds to make buffer navigation easier.
--  Use Shift+<hl> to switch between buffers
vim.keymap.set('n', 'H', '<Cmd>bprev<CR>', { desc = 'Move focus to the left buffer' })
vim.keymap.set('n', 'L', '<Cmd>bnext<CR>', { desc = 'Move focus to the right buffer' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- LSP
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'LSP Code action' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Jump to definition' })

-- Telescope keybinds
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files { follow = true }
end, { desc = 'Telescope files' })
vim.keymap.set('n', '<leader>fF', function()
  builtin.find_files { follow = true, hidden = true, no_ignore = true }
end, { desc = 'Telescope all files' })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope words in working directory' })
vim.keymap.set('n', '<leader>fw', function()
  builtin.live_grep {
    additional_args = function(args)
      return vim.list.extend(args, { '-L' })
    end,
  }
end, { desc = 'Telescope words in working directory' })
vim.keymap.set('n', '<leader>fW', function()
  builtin.live_grep {
    additional_args = function(args)
      return vim.list.extend(args, { '-L', '--hidden', '--no-ignore' })
    end,
  }
end, { desc = 'Telescope words in all files in working directory' })
vim.keymap.set('n', '<leader>f/', builtin.current_buffer_fuzzy_find, { desc = 'Telescope words in currend buffer' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Telescope LSP references' })

-- Leap keybinds
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-from-window)')

-- LazyGit
vim.keymap.set('n', '<leader>gg', '<Cmd>LazyGit<Cr>')

-- Nvim spider
vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })

-- Yanky
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

vim.keymap.set('n', '<c-p>', '<Plug>(YankyPreviousEntry)')
vim.keymap.set('n', '<c-n>', '<Plug>(YankyNextEntry)')

-- FineCmdline
vim.keymap.set('n', '<CR>', '<cmd>FineCmdline<CR>', { noremap = true })

-- vim: ts=2 sts=2 sw=2 et
