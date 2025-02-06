-- [[ Setting options ]]
local opt = vim.opt

-- Enables 24-bit RGB in TUI
opt.termguicolors = true

-- Make line numbers default
opt.number = true
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Set statuscolumn
opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

-- Sync clipboard between OS and Neovim.
opt.clipboard = 'unnamedplus'

-- What to show when triggering completion in insert mode
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Confirm to save changes before exiting modified buffer
opt.confirm = true

-- Do indenting with space instead of tab
opt.expandtab = true

-- Width for shifting commands such as `>>`, `<<` and `==`
opt.shiftwidth = 4

-- Round indent to multiple of `shiftwidth`. Applies to `<`. and `>`.
opt.shiftround = true

-- Display width of `\t` character
opt.tabstop = 4

-- Copy indent from current line when starting a new line
opt.autoindent = true

-- Automatically increase indent level in certain situations (e.g. after { or certain keywords)
opt.smartindent = true

-- Enable auto indent on linebreaks
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time to display which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 15

-- Languages for spell checking
opt.spelllang = { 'de', 'en' }

-- Visually track opening and closing parentheses, brackets, etc.
opt.showmatch = true

-- Disable swapfiles and backups
opt.swapfile = false
opt.backup = false

-- Improve scrolling performance in larger files
opt.lazyredraw = true

-- Limit syntax highlighting to first 200 columns
opt.synmaxcol = 200

-- Enhance command-line completion
opt.wildmenu = true
opt.wildmode = { 'longest:full', 'full' }
opt.wildignore = { '*.o', '*.obj', '*.jpg', '*.png', '*.gif', '*.zip', '*.pyc', '*.DS_Store' }

-- Minimum window width
opt.winminwidth = 5

-- Disable line wrap
opt.wrap = false

-- Allow cursor to move where there is no text in visual block mode
opt.virtualedit = 'block'

-- Optimized automatic folding
opt.smoothscroll = true
opt.foldexpr = "v:lua.require'util.ui'.foldexpr()"
opt.foldmethod = 'expr'
opt.foldtext = ''

-- Folding look
opt.fillchars = {
    foldopen = '',
    foldclose = '',
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    eob = ' ',
}

-- vim: ts=2 sts=2 sw=2 et
