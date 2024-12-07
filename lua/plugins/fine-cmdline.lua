later(function()
  add { source = 'VonHeikemen/fine-cmdline.nvim', depends = { 'MunifTanjim/nui.nvim' } }
  require('fine-cmdline').setup {
    cmdline = {
      prompt = '> ',
    },
    popup = {
      position = {
        row = '50%',
      },
    },
  }
end)
