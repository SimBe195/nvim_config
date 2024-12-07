now(function()
  add { source = 'nvim-lualine/lualine.nvim' }

  require('lualine').setup {
    options = {
      theme = 'catppuccin',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { { 'filetype', icon_only = true } },
      lualine_y = { 'progress' },
      lualine_z = { { 'datetime', style = '%d. %h | %H:%M' } },
    },
  }
end)
