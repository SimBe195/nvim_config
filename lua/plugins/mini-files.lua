later(function()
  require('mini.files').setup {
    mappings = {
      close = 'q',
      go_in = 'l',
      go_in_plus = 'L',
      go_out = 'h',
      go_out_plus = 'H',
      mark_goto = "'",
      mark_set = 'm',
      reset = '<BS>',
      reveal_cwd = '@',
      show_help = 'g?',
      synchronize = '<C-y>',
      trim_left = '<',
      trim_right = '>',
    },
    windows = {
      preview = true,
    },
  }
end)
