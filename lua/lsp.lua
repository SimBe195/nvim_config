now(function()
  -- Manages installations of lsp's, formatters, debuggers and linters
  add { source = 'williamboman/mason.nvim' }

  -- LSP

  add {
    source = 'williamboman/mason-lspconfig.nvim',
    depends = { 'williamboman/mason.nvim' },
  }
  add { source = 'hrsh7th/cmp-nvim-lsp' }
  add { source = 'neovim/nvim-lspconfig' }

  -- Formatter

  add {
    source = 'zapling/mason-conform.nvim',
    depends = { 'williamboman/mason.nvim' },
  }
  add { source = 'stevearc/conform.nvim' }

  -- Mason plugin setups

  require('mason').setup()

  -- Automatically install lsp's that are set up with lspconfig via Mason
  require('mason-lspconfig').setup { automatic_installation = true }

  -- Automatically install formatters that are set up with conform via Mason
  require('mason-conform').setup()

  -- lspconfig

  local lspconfig = require 'lspconfig'
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig.bashls.setup { capabilities = capabilities }
  lspconfig.clangd.setup { capabilities = capabilities }
  lspconfig.neocmake.setup { capabilities = capabilities }
  lspconfig.jsonls.setup { capabilities = capabilities }
  lspconfig.ltex.setup { capabilities = capabilities }
  lspconfig.lua_ls.setup {
    on_init = function(client)
      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          version = 'LuaJIT',
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      })
    end,
    settings = {
      Lua = {},
    },
    capabilities = capabilities,
  }
  lspconfig.marksman.setup { capabilities = capabilities }
  lspconfig.pyright.setup { capabilities = capabilities }
  lspconfig.ruff.setup { capabilities = capabilities }
  lspconfig.rust_analyzer.setup { capabilities = capabilities }
  lspconfig.textlsp.setup { capabilities = capabilities }
  lspconfig.lemminx.setup { capabilities = capabilities }
  lspconfig.yamlls.setup { capabilities = capabilities }

  -- conform

  require('conform').setup {
    formatters_by_ft = {
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      latex = { 'latexindent' },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      ['*'] = { 'codespell' }, -- Run on all filetypes
      ['_'] = { 'trim_whitespace' }, -- Run on files that don't have other filetypes configured
    },
    default_format_opts = {
      lsp_format = 'fallback', -- Use lsp formatting if no other formatters are available
    },
    notify_on_error = true,
  }
end)
