-- [[ Basic Keymaps ]]

-- Easier exiting into normal mode
vim.keymap.set('i', 'jk', '<Esc>')

vim.keymap.set('n', '<Leader>lf', function()
    require('conform').format { async = true }
end, { desc = 'Format buffer' })

vim.keymap.set('n', '<Leader>w', '<Cmd>w<Cr>', { desc = 'Save buffer' })
vim.keymap.set('n', '<Leader>c', '<Cmd>bdelete<Cr>', { desc = 'Close buffer' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<Cr>')

-- Diagnostic keymaps
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- Exit terminal mode in the builtin terminal.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<Leader>e', '<Cmd>Oil --float<Cr>', { desc = 'Open parent directory' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keybinds to make buffer navigation easier.
--  Use Shift+<hl> to switch between buffers
vim.keymap.set('n', 'H', '<Cmd>bprev<Cr>', { desc = 'Move focus to the left buffer' })
vim.keymap.set('n', 'L', '<Cmd>bnext<Cr>', { desc = 'Move focus to the right buffer' })

-- Telescope keybinds
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<Leader>ff', builtin.find_files, { desc = 'Telescope files' })
vim.keymap.set('n', '<Leader>fw', builtin.live_grep, { desc = 'Telescope words in working directory' })
vim.keymap.set('n', '<Leader>f/', builtin.current_buffer_fuzzy_find, { desc = 'Telescope words in currend buffer' })
vim.keymap.set('n', '<Leader>r', builtin.resume, { desc = 'Telescope resume previous search' })
vim.keymap.set('n', '<Leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<Leader>fr', builtin.lsp_references, { desc = 'Telescope LSP references' })

-- Leap keybinds
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-from-window)')

-- LazyGit
vim.keymap.set('n', '<Leader>gg', '<Cmd>LazyGit<Cr>')

-- Nvim spider
vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<Cr>", { desc = 'Spider-w' })
vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<Cr>", { desc = 'Spider-e' })
vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<Cr>", { desc = 'Spider-b' })

-- Yanky
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

vim.keymap.set('n', '<C-p>', '<Plug>(YankyPreviousEntry)')
vim.keymap.set('n', '<C-n>', '<Plug>(YankyNextEntry)')

-- LspSaga
vim.keymap.set({ 'n', 't' }, '<Leader>tt', '<Cmd>Lspsaga term_toggle<Cr>.', { desc = 'Toggle floating terminal' })
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<Cr>', { desc = 'Display hover documentation' })
vim.keymap.set('n', '<Leader>la', '<Cmd>Lspsaga code_action<Cr>', { desc = 'LSP Code action' })
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga goto_definition<Cr>', { desc = 'Jump to definition' })
vim.keymap.set('n', '<Leader>ld', '<Cmd>Lspsaga peek_definition<Cr>', { desc = 'Peek definition' })
vim.keymap.set('n', '<Leader>lr', '<Cmd>Lspsaga rename<Cr>', { desc = 'Rename symbol' })
vim.keymap.set('n', '[d', '<Cmd>Lspsaga diagnostic_jump_prev<Cr>', { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', '<Cmd>Lspsaga diagnostic_jump_next<Cr>', { desc = 'Go to next diagnostic' })

-- vim: ts=2 sts=2 sw=2 et
