-- [[ Setting options ]]
local opt = vim.opt

-- Width for shifting commands such as `>>`, `<<` and `==`
opt.shiftwidth = 4

-- Display width of `\t` character
opt.tabstop = 4

-- Copy indent from current line when starting a new line
opt.autoindent = true

-- Enable auto indent on linebreaks
opt.breakindent = true

-- Sets how neovim will display certain whitespace characters in the editor.
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 15

-- Languages for spell checking
opt.spelllang = { 'de', 'en' }

-- Limit syntax highlighting to first 500 columns
opt.synmaxcol = 500

-- Enhance command-line completion
opt.wildmenu = true
opt.wildmode = { 'longest:full', 'full' }
opt.wildignore = { '*.o', '*.obj', '*.jpg', '*.png', '*.gif', '*.zip', '*.pyc', '*.DS_Store' }

-- Disable line wrap
opt.wrap = false

-- Folding look
opt.fillchars = {
    foldopen = '',
    foldclose = '',
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    eob = ' ',
}

-- Clipboard
if vim.env.SSH_TTY then
    opt.clipboard:append { 'unnamed', 'unnamedplus' }
    local function paste()
        return { vim.fn.split(vim.fn.getreg '', '\n'), vim.fn.getregtype '' }
    end
    local osc52 = require 'vim.ui.clipboard.osc52'
    vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
            ['+'] = osc52.copy '+',
            ['*'] = osc52.copy '*',
        },
        paste = {
            ['+'] = paste,
            ['*'] = paste,
        },
    }
end

-- vim: ts=2 sts=2 sw=2 et
