-- [[ Basic Keymaps ]]
local map = vim.keymap.set

local function root_opts(opts)
    return require('util.root').opts(opts)
end

local function picker(command, opts)
    return function()
        local resolved = type(opts) == 'function' and opts() or opts or {}
        Snacks.picker[command](resolved)
    end
end

map('n', '<Leader>lf', function()
    require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format buffer' })

map('n', '<Leader>w', '<Cmd>w<Cr>', { desc = 'Save buffer' })
map('n', '<Leader>bd', function()
    Snacks.bufdelete()
end, { desc = 'Close buffer' })
map('n', '<Leader>bD', function()
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
map('n', '<Leader>xd', vim.diagnostic.open_float, { desc = 'Line diagnostics' })
map('n', '<Leader>xq', vim.diagnostic.setloclist, { desc = 'Diagnostic loclist' })

-- Exit terminal mode in the builtin terminal.
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
map('n', '<C-h>', function()
    require('util.tmux').navigate 'h'
end, { desc = 'Navigate left' })
map('n', '<C-j>', function()
    require('util.tmux').navigate 'j'
end, { desc = 'Navigate down' })
map('n', '<C-k>', function()
    require('util.tmux').navigate 'k'
end, { desc = 'Navigate up' })
map('n', '<C-l>', function()
    require('util.tmux').navigate 'l'
end, { desc = 'Navigate right' })
map('n', '<C-\\>', function()
    require('util.tmux').navigate 'p'
end, { desc = 'Navigate previous' })

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
map(
    'n',
    '<Leader><Space>',
    picker('files', function()
        return root_opts()
    end),
    { desc = 'Find files root' }
)
map('n', '<Leader>,', picker 'buffers', { desc = 'Buffers' })
map('n', '<Leader>:', picker 'command_history', { desc = 'Command history' })
map(
    'n',
    '<Leader>/',
    picker('grep', function()
        return root_opts()
    end),
    { desc = 'Grep root' }
)

map(
    'n',
    '<Leader>ff',
    picker('files', function()
        return root_opts()
    end),
    { desc = 'Files root' }
)
map('n', '<Leader>fF', picker 'files', { desc = 'Files cwd' })
map('n', '<Leader>fg', picker 'git_files', { desc = 'Git files' })
map('n', '<Leader>fb', picker 'buffers', { desc = 'Buffers' })
map('n', '<Leader>fh', picker 'help', { desc = 'Help tags' })
map('n', '<Leader>fo', picker 'recent', { desc = 'Recent files' })
map('n', '<Leader>fp', picker 'projects', { desc = 'Projects' })
map('n', '<Leader>f/', picker 'lines', { desc = 'Buffer lines' })
map('n', '<Leader>fR', picker 'resume', { desc = 'Resume picker' })

map(
    'n',
    '<Leader>sg',
    picker('grep', function()
        return root_opts()
    end),
    { desc = 'Grep root' }
)
map('n', '<Leader>sG', picker 'grep', { desc = 'Grep cwd' })
map('n', '<Leader>sb', picker 'grep_buffers', { desc = 'Grep open buffers' })
map(
    { 'n', 'x' },
    '<Leader>sw',
    picker('grep_word', function()
        return root_opts()
    end),
    { desc = 'Word root' }
)
map({ 'n', 'x' }, '<Leader>sW', picker 'grep_word', { desc = 'Word cwd' })
map('n', '<Leader>ss', picker 'lsp_symbols', { desc = 'LSP symbols' })
map('n', '<Leader>sS', picker 'lsp_workspace_symbols', { desc = 'LSP workspace symbols' })
map('n', '<Leader>sk', picker 'keymaps', { desc = 'Keymaps' })
map('n', '<Leader>su', picker 'undo', { desc = 'Undo history' })

map('n', '<Leader>xx', picker 'diagnostics', { desc = 'Diagnostics' })
map('n', '<Leader>xX', picker 'diagnostics_buffer', { desc = 'Buffer diagnostics' })

map('n', '<Leader>uC', picker 'colorschemes', { desc = 'Colorschemes' })

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

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('__lsp_keymaps__', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
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
        map(
            { 'n', 'x' },
            '<Leader>la',
            vim.lsp.buf.code_action,
            vim.tbl_extend('force', opts, { desc = 'LSP code action' })
        )
        map('n', '<Leader>lr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))
        map('n', '<Leader>lR', function()
            Snacks.rename.rename_file()
        end, vim.tbl_extend('force', opts, { desc = 'Rename file' }))
        map('n', '<Leader>li', '<Cmd>LspInfo<Cr>', vim.tbl_extend('force', opts, { desc = 'LSP info' }))
        map('n', '<Leader>lA', function()
            local inc_rename = require 'inc_rename'
            return ':' .. inc_rename.config.cmd_name .. ' ' .. vim.fn.expand '<cword>'
        end, vim.tbl_extend('force', opts, { expr = true, desc = 'Incremental rename' }))
        if client and client.name == 'clangd' then
            map(
                'n',
                '<Leader>lh',
                '<cmd>LspClangdSwitchSourceHeader<cr>',
                vim.tbl_extend('force', opts, { desc = 'Switch source/header' })
            )
        end
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
