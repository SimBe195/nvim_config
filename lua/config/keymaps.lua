-- [[ Basic Keymaps ]]
local map = vim.keymap.set

local root_markers = {
    '.git',
    'Cargo.toml',
    'CMakeLists.txt',
    'pyproject.toml',
    'package.json',
    'Makefile',
}

local function root()
    return vim.fs.root(0, root_markers) or vim.uv.cwd()
end

local function fzf(command, opts)
    return function()
        local resolved = type(opts) == 'function' and opts() or opts or {}
        require('fzf-lua')[command](resolved)
    end
end

map('n', '<Leader>lf', function()
    require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format buffer' })

map('n', '<Leader>w', '<Cmd>w<Cr>', { desc = 'Save buffer' })
map('n', '<Leader>c', function()
    Snacks.bufdelete()
end, { desc = 'Close buffer' })
map('n', '<Leader>C', function()
    Snacks.bufdelete.other()
end, { desc = 'Close all other buffers' })
map('n', '<Leader>qq', '<Cmd>qa<Cr>', { desc = 'Exit neovim' })

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- quickfix navigation
map('n', '[q', vim.cmd.cprev, { desc = 'Previous quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix' })

-- Clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<Cmd>nohlsearch<Cr>')

-- Diagnostic keymaps
map('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic loclist' })
map('n', '<Leader>d', vim.diagnostic.open_float, { desc = 'Open diagnostics in float' })

-- Exit terminal mode in the builtin terminal.
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Explorers
map('n', '<Leader>e', function()
    Snacks.explorer { cwd = root() }
end, { desc = 'Explorer root' })
map('n', '<Leader>E', function()
    Snacks.explorer()
end, { desc = 'Explorer cwd' })
map('n', '<Leader>fe', function()
    Snacks.explorer { cwd = root() }
end, { desc = 'Explorer root' })
map('n', '<Leader>fE', function()
    Snacks.explorer()
end, { desc = 'Explorer cwd' })
map('n', '<Leader>fm', function()
    require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
end, { desc = 'Open mini.files at current file' })
map('n', '<Leader>fM', function()
    require('mini.files').open(vim.uv.cwd(), true)
end, { desc = 'Open mini.files cwd' })

-- Window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })

-- Split current window
map('n', '-', '<C-W>s', { desc = 'Split window horizontally' })
map('n', '|', '<C-W>v', { desc = 'Split window vertically' })

-- Resize current window
map('n', '<C-Up>', function()
    require('util.ui').smart_resize 'up'
end, { desc = 'Resize window upward' })
map('n', '<C-Down>', function()
    require('util.ui').smart_resize 'down'
end, { desc = 'Resize window downward' })
map('n', '<C-Left>', function()
    require('util.ui').smart_resize 'left'
end, { desc = 'Resize window leftward' })
map('n', '<C-Right>', function()
    require('util.ui').smart_resize 'right'
end, { desc = 'Resize window rightward' })

-- Buffer navigation
map('n', '<S-h>', '<Cmd>bprev<Cr>', { desc = 'Previous buffer' })
map('n', '<S-l>', '<Cmd>bnext<Cr>', { desc = 'Next buffer' })

-- Pickers
map('n', '<Leader><Space>', function()
    Snacks.picker.files { cwd = root() }
end, { desc = 'Find files root' })
map('n', '<Leader>,', function()
    Snacks.picker.buffers()
end, { desc = 'Buffers' })
map('n', '<Leader>:', function()
    Snacks.picker.command_history()
end, { desc = 'Command history' })
map('n', '<Leader>ff', fzf('files', function()
    return { cwd = root() }
end), { desc = 'Files root' })
map('n', '<Leader>fF', fzf('files'), { desc = 'Files cwd' })
map('n', '<Leader>fg', fzf('git_files'), { desc = 'Git files' })
map('n', '<Leader>fw', fzf('live_grep', function()
    return { cwd = root() }
end), { desc = 'Grep root' })
map('n', '<Leader>fW', fzf('live_grep'), { desc = 'Grep cwd' })
map('n', '<Leader>f/', fzf('blines'), { desc = 'Buffer lines' })
map('n', '<Leader>fb', fzf('buffers'), { desc = 'Buffers' })
map('n', '<Leader>fh', fzf('help_tags'), { desc = 'Help tags' })
map('n', '<Leader>fo', fzf('oldfiles'), { desc = 'Recent files' })
map('n', '<Leader>fp', function()
    Snacks.picker.projects()
end, { desc = 'Projects' })
map('n', '<Leader>fr', fzf('lsp_references'), { desc = 'LSP references' })
map('n', '<Leader>r', fzf('resume'), { desc = 'Resume picker' })

map('n', '<Leader>sd', function()
    Snacks.picker.diagnostics()
end, { desc = 'Diagnostics' })
map('n', '<Leader>sD', function()
    Snacks.picker.diagnostics_buffer()
end, { desc = 'Buffer diagnostics' })
map('n', '<Leader>ss', function()
    Snacks.picker.lsp_symbols()
end, { desc = 'LSP symbols' })
map('n', '<Leader>sS', function()
    Snacks.picker.lsp_workspace_symbols()
end, { desc = 'LSP workspace symbols' })
map('n', '<Leader>sk', function()
    Snacks.picker.keymaps()
end, { desc = 'Keymaps' })
map('n', '<Leader>su', function()
    Snacks.picker.undo()
end, { desc = 'Undo history' })
map('n', '<Leader>uC', function()
    Snacks.picker.colorschemes()
end, { desc = 'Colorschemes' })

-- Nvim spider
map({ 'n', 'o', 'x' }, 'w', function()
    require('spider').motion 'w'
end, { desc = 'Spider-w' })
map({ 'n', 'o', 'x' }, 'e', function()
    require('spider').motion 'e'
end, { desc = 'Spider-e' })
map({ 'n', 'o', 'x' }, 'b', function()
    require('spider').motion 'b'
end, { desc = 'Spider-b' })

-- Yanky
map({ 'n', 'x' }, '<Leader>p', function()
    Snacks.picker.yanky()
end, { desc = 'Yank history' })
map({ 'n', 'x' }, 'y', '<Plug>(YankyYank)', { desc = 'Yank text' })
map({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', { desc = 'Put after cursor' })
map({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', { desc = 'Put before cursor' })
map({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)', { desc = 'Put after selection' })
map({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)', { desc = 'Put before selection' })
map('n', '<C-p>', '<Plug>(YankyPreviousEntry)', { desc = 'Previous yank entry' })
map('n', '<C-n>', '<Plug>(YankyNextEntry)', { desc = 'Next yank entry' })
map('n', '[y', '<Plug>(YankyCycleForward)', { desc = 'Cycle yank forward' })
map('n', ']y', '<Plug>(YankyCycleBackward)', { desc = 'Cycle yank backward' })

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('__lsp_keymaps__', { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf }
        map('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover documentation' }))
        map('n', 'gK', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature help' }))
        map('i', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature help' }))
        map('n', 'gd', function()
            Snacks.picker.lsp_definitions()
        end, vim.tbl_extend('force', opts, { desc = 'Goto definition' }))
        map('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Goto declaration' }))
        map('n', 'gi', function()
            Snacks.picker.lsp_implementations()
        end, vim.tbl_extend('force', opts, { desc = 'Goto implementation' }))
        map('n', 'gy', function()
            Snacks.picker.lsp_type_definitions()
        end, vim.tbl_extend('force', opts, { desc = 'Goto type definition' }))
        map('n', 'gr', function()
            Snacks.picker.lsp_references()
        end, vim.tbl_extend('force', opts, { desc = 'References', nowait = true }))
        map({ 'n', 'x' }, '<Leader>la', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'LSP code action' }))
        map('n', '<Leader>lr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))
        map('n', '<Leader>lR', function()
            Snacks.rename.rename_file()
        end, vim.tbl_extend('force', opts, { desc = 'Rename file' }))
        map('n', '<Leader>li', '<Cmd>LspInfo<Cr>', vim.tbl_extend('force', opts, { desc = 'LSP info' }))
        map('n', '<Leader>lA', function()
            local inc_rename = require 'inc_rename'
            return ':' .. inc_rename.config.cmd_name .. ' ' .. vim.fn.expand '<cword>'
        end, vim.tbl_extend('force', opts, { expr = true, desc = 'Incremental rename' }))
        map('n', '<Leader>lh', '<cmd>LspClangdSwitchSourceHeader<cr>', vim.tbl_extend('force', opts, { desc = 'Switch source/header' }))
        map('n', '<Leader>K', '<plug>(vimtex-doc-package)', vim.tbl_extend('force', opts, { desc = 'Vimtex docs', silent = true }))
    end,
})

-- Snacks
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
map('n', '<leader>H', function()
    require('harpoon'):list():add()
end, { desc = 'Harpoon file' })
map('n', '<leader>h', function()
    local harpoon = require 'harpoon'
    harpoon.ui:toggle_quick_menu(harpoon:list())
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
