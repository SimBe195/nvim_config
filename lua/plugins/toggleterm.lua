later(function()
  add { source = 'akinsho/toggleterm.nvim' }
  require('toggleterm').setup {
    open_mapping = '<F7>',
    direction = 'float',
    border = 'shadow',
    title_pos = 'center',
  }
end)
