local lspconfig = require 'lspconfig'
local mason_lspconfig = require 'mason-lspconfig'

local function lsp_rename_file(old_path, new_path)
    local clients = vim.lsp.get_active_clients()
    for _, client in pairs(clients) do
        if client.server_capabilities.workspace.workspaceEdit then
            local params = vim.lsp.util.make_rename_params()
            params.oldUri = vim.uri_from_fname(old_path)
            params.newUri = vim.uri_from_fname(new_path)
            client.request('workspace/applyEdit', { label = 'Rename File', edit = { changes = {} } })
        end
    end
end

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
            capabilities = vim.lsp.protocol.make_client_capabilities(),
            settings = servers[server_name],
        }
    end,
}
