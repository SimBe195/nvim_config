now(function()
  add { source = 'nvimdev/lspsaga.nvim', depends = { 'nvim-treesitter/nvim-treesitter' } }
  require('lspsaga').setup()
end)
