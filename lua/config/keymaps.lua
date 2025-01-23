-- [[ Basic Keymaps ]]
local map = vim.keymap.set

map('n', '<Leader>lf', function()
    require('conform').format { async = true }
end, { desc = 'Format buffer' })

map('n', '<Leader>w', '<Cmd>w<Cr>', { desc = 'Save buffer' })
map('n', '<Leader>c', function()
    Snacks.bufdelete()
end, { desc = 'Close buffer' })
map('n', '<Leader>qq', '<Cmd>qa<Cr>', { desc = 'Exit neovim' })

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- quickfix navigation
map('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })

-- Clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<Cmd>nohlsearch<Cr>')

-- Diagnostic keymaps
map('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- Exit terminal mode in the builtin terminal.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map('n', '<Leader>e', function()
    local MiniFiles = require 'mini.files'
    local _ = MiniFiles.close() or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    vim.defer_fn(function()
        MiniFiles.reveal_cwd()
    end, 30)
end, { desc = 'Open file exporer' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Split current window
map('n', '-', '<C-W>s', { desc = 'Split window horizontally' })
map('n', '|', '<C-W>v', { desc = 'Split window vertically' })

-- Resize current window
map('n', '<C-Up>', "<cmd>lua require'util.ui'.smart_resize('up')<Cr>", { desc = 'Resize window upward' })
map('n', '<C-Down>', "<cmd>lua require'util.ui'.smart_resize('down')<Cr>", { desc = 'Resize window downward' })
map('n', '<C-Left>', "<cmd>lua require'util.ui'.smart_resize('left')<Cr>", { desc = 'Resize window leftward' })
map('n', '<C-Right>', "<cmd>lua require'util.ui'.smart_resize('right')<Cr>", { desc = 'Resize window rightward' })

-- Keybinds to make buffer navigation easier.
--  Use Shift+<hl> to switch between buffers
map('n', '<S-h>', '<Cmd>bprev<Cr>', { desc = 'Prev buffer' })
map('n', '<S-l>', '<Cmd>bnext<Cr>', { desc = 'Next buffer' })

-- Telescope keybinds
local builtin = require 'telescope.builtin'
map('n', '<Leader>ff', builtin.find_files, { desc = 'Telescope files' })
map('n', '<Leader>fw', builtin.live_grep, { desc = 'Telescope words in working directory' })
map('n', '<Leader>f/', builtin.current_buffer_fuzzy_find, { desc = 'Telescope words in currend buffer' })
map('n', '<Leader>r', builtin.resume, { desc = 'Telescope resume previous search' })
map('n', '<Leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<Leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
map('n', '<Leader>fr', builtin.lsp_references, { desc = 'Telescope LSP references' })

-- Leap keybinds
map({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
map({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-from-window)')

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

-- Lsp
map('n', 'K', function()
    return vim.lsp.buf.hover()
end, { desc = 'Display hover documentation' })
map('n', 'gK', function()
    return vim.lsp.buf.signature_help()
end, { desc = 'Signature help' })
map('i', '<C-k>', function()
    return vim.lsp.buf.signature_help()
end, { desc = 'Signature help' })
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Jump to definition' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Jump to declaration' })
map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Jump to implementation' })
map('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Jump to type definition' })
map('n', 'gr', vim.lsp.buf.references, { desc = 'References' })
map('n', '<Leader>la', vim.lsp.buf.code_action, { desc = 'LSP code action' })
map('n', '<Leader>lr', vim.lsp.buf.rename, { desc = 'Rename' })
map('n', '<Leader>lR', function()
    Snacks.rename.rename_file()
end, { desc = 'Rename file' })
map('n', '[d', '<Cmd>Lspsaga diagnostic_jump_prev<Cr>', { desc = 'Go to previous diagnostic' })
map('n', ']d', '<Cmd>Lspsaga diagnostic_jump_next<Cr>', { desc = 'Go to next diagnostic' })

-- Snacks
map('n', '<leader>c', function()
    Snacks.bufdelete()
end, { desc = 'Close buffer' })

map('n', '<leader>C', function()
    Snacks.bufdelete.other()
end, { desc = 'Close all other buffers' })

map('n', '<leader>gg', function()
    Snacks.lazygit()
end, { desc = 'Lazygit' })

map('n', '<leader>gf', function()
    Snacks.lazygit.log_file()
end, { desc = 'Lazygit current file history' })

map('n', '<leader>gl', function()
    Snacks.lazygit.log()
end, { desc = 'Lazygit log' })

-- Harpoon
map('n', '<leader>h', function()
    require('harpoon'):list():add()
end, { desc = 'Harpoon file' })

local conf = require('telescope.config').values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require('telescope.pickers')
        .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
                results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
        })
        :find()
end

map('n', '<leader>fh', function()
    toggle_telescope(require('harpoon'):list())
end, { desc = 'Harpoon quick menu' })

map('n', '<C-S-P>', function()
    require('harpoon'):list():prev()
end, { desc = 'Previous harpoon buffer' })

map('n', '<C-S-N>', function()
    require('harpoon'):list():next()
end, { desc = 'Next harpoon buffer' })

for i = 1, 5 do
    map('n', '<leader>' .. i, function()
        require('harpoon'):list():select(i)
    end, { desc = 'Harpoon to file ' .. i })
end
-- vim: ts=2 sts=2 sw=2 et
