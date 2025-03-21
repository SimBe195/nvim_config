-- [[ Basic Keymaps ]]
local map = vim.keymap.set

-- Resize current window
map('n', '<C-Up>', "<cmd>lua require'util.ui'.smart_resize('up')<Cr>", { desc = 'Resize window upward' })
map('n', '<C-Down>', "<cmd>lua require'util.ui'.smart_resize('down')<Cr>", { desc = 'Resize window downward' })
map('n', '<C-Left>', "<cmd>lua require'util.ui'.smart_resize('left')<Cr>", { desc = 'Resize window leftward' })
map('n', '<C-Right>', "<cmd>lua require'util.ui'.smart_resize('right')<Cr>", { desc = 'Resize window rightward' })

-- Nvim spider
map({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<Cr>", { desc = 'Spider-w' })
map({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<Cr>", { desc = 'Spider-e' })
map({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<Cr>", { desc = 'Spider-b' })

-- Yanky
map({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
map({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
map({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
map({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

map('n', '<C-p>', '<Plug>(YankyPreviousEntry)')
map('n', '<C-n>', '<Plug>(YankyNextEntry)')

-- vim: ts=2 sts=2 sw=2 et
