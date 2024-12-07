now(function()
  add { source = 'nvim-treesitter/nvim-treesitter' }

  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'c',
      'cpp',
      'lua',
      'vim',
      'vimdoc',
      'markdown',
      'python',
      'rust',
    },
    highlight = {
      enable = true, -- Enable highlighting
      additional_vim_regex_highlighting = false, -- Use only Treesitter highlighting
    },
    auto_install = true,
  }
end)
