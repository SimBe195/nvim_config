-- Other miscallaneous or short mini plugins

later(function()
  require('mini.animate').setup()
  require('mini.tabline').setup()
  require('mini.icons').setup()
  require('mini.git').setup()
  require('mini.jump').setup()
  require('mini.jump2d').setup { mappings = { start_jumping = 's' } }
  require('mini.notify').setup()
  require('mini.pairs').setup()
  require('mini.splitjoin').setup()
end)
