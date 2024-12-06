now(function()
  add {
    source = 'catppuccin/nvim',
    name = 'catppuccin',
  }
  require('catppuccin').setup {
    flavout = 'mocha',
    transparent_background = true,
    integrations = {
      cmp = false,
      gitsigns = false,
      nvimtree = false,
      treesitter = false,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = '',
      },
      -- For more plugins integrations see https://github.com/catppuccin/nvim#integrations
    },
  }

  vim.cmd.colorscheme 'catppuccin'
end)
