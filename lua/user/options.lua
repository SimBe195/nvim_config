-- [[ Setting options ]]
-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
-- Remove this option if OS clipboard should remain independent.
vim.opt.clipboard = 'unnamed,unnamedplus'

-- Do indenting with space instead of tab
vim.opt.expandtab = true

-- Width for shifting commands such as '>>', '<<' and '==
vim.opt.shiftwidth = 4

-- Display width of '\t' character
vim.opt.tabstop = 4

-- Copy indent from current line when starting a new line
vim.opt.autoindent = true

-- Automatically increase indent level in certain situations (e.g. after { or certain keywords)
vim.opt.smartindent = true

-- Enable auto indent on linebreaks
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- Languages for spell checking
vim.opt.spelllang = 'de,en'

-- Visually track opening and closing parentheses, brackets, etc.
vim.opt.showmatch = true

-- Disable swapfiles and backups
vim.opt.swapfile = false
vim.opt.backup = false

-- Improve scrolling performance in larger files
vim.opt.lazyredraw = true

-- Limit syntax highlighting to first 200 columns
vim.opt.synmaxcol = 200

-- Enhance command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignore = '*.o,*.obj,*.jpg,*.png,*.gif,*.zip,*.pyc,*.DS_Store'

-- vim: ts=2 sts=2 sw=2 et
