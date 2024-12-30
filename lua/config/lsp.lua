local lspconfig = require 'lspconfig'
local mason_lspconfig = require 'mason-lspconfig'

-- LSP servers and their specific configurations
local servers = {
    lua_ls = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = { enable = false },
        },
    },
    basedpyright = {},
    clangd = {},
    rust_analyzer = {},
    julials = {},
}

-- Setup LSP servers
mason_lspconfig.setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {
            capabilities = require('blink.cmp').get_lsp_capabilities(),
            -- capabilities = vim.lsp.protocol.make_client_capabilities(),
            settings = servers[server_name],
        }
    end,
}
