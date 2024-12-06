-- Other miscallaneous or short mini plugins

later(function()
  require('mini.animate').setup()
  require('mini.tabline').setup()
  require('mini.icons').setup()
  require('mini.cursorword').setup { delay = 50 }
end)
