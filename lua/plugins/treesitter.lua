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
    auto_install = true,
  }
end)
