now(function()
  add {
    source = 'nvim-telescope/telescope.nvim',
    depends = { 'nvim-lua/plenary.nvim' },
  }

  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ['<C-k>'] = 'move_selection_previous',
          ['<C-j>'] = 'move_selection_next',
          ['<C-y>'] = 'select_default',
        },
        n = {
          ['q'] = 'close',
          ['<C-y>'] = 'select_default',
        },
      },
    },
  }
end)
