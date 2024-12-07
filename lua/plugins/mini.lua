-- Other miscallaneous or short mini plugins

later(function()
  require('mini.jump').setup()
  require('mini.jump2d').setup { mappings = { start_jumping = 's' } }
  require('mini.notify').setup()
  require('mini.pairs').setup()
  require('mini.splitjoin').setup()
end)

now(function()
  require('mini.animate').setup()
  require('mini.git').setup()
  require('mini.icons').setup()
  require('mini.tabline').setup()
end)
