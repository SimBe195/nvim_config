local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.fileOperations = {
    didRename = true,
    willRename = true,
}

local ok_blink, blink = pcall(require, 'blink.cmp')
if ok_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
end

local function with_capabilities(config)
    return vim.tbl_deep_extend('force', { capabilities = capabilities }, config or {})
end

local servers = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    checkThirdParty = false,
                    library = vim.api.nvim_get_runtime_file('', true),
                },
                completion = { callSnippet = 'Replace' },
                telemetry = { enable = false },
            },
        },
    },
    basedpyright = {},
    ruff = {
        cmd_env = { RUFF_TRACE = 'messages' },
        init_options = {
            settings = {
                logLevel = 'error',
            },
        },
    },
    clangd = {
        cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=llvm',
            '--query-driver=/usr/bin/g++,/usr/bin/gcc,/usr/bin/c++,/usr/bin/cc',
        },
        capabilities = {
            offsetEncoding = { 'utf-16' },
        },
        init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
        },
        root_markers = {
            'compile_commands.json',
            'compile_flags.txt',
            'configure.ac',
            'Makefile',
            'configure.in',
            'config.h.in',
            'meson.build',
            'meson_options.txt',
            'build.ninja',
            '.git',
        },
    },
    neocmake = {},
    jsonls = {
        before_init = function(_, new_config)
            local ok_schema, schemastore = pcall(require, 'schemastore')
            if not ok_schema then
                return
            end
            new_config.settings = new_config.settings or {}
            new_config.settings.json = new_config.settings.json or {}
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, schemastore.json.schemas())
        end,
        settings = {
            json = {
                format = { enable = true },
                validate = { enable = true },
            },
        },
    },
    marksman = {},
    texlab = {},
    taplo = {},
    bashls = {},
    julials = {},
}

if vim.g.sidekick_nes ~= false then
    servers.copilot = {}
end

vim.lsp.config('*', { capabilities = capabilities })

for server, config in pairs(servers) do
    vim.lsp.config(server, with_capabilities(config))
end

local mason_servers = {}
local mason_exclude = { 'rust_analyzer' }
local ok_mason_map, mason_map = pcall(function()
    return require('mason-lspconfig.mappings').get_mason_map().lspconfig_to_package
end)

for server in pairs(servers) do
    if ok_mason_map and mason_map[server] then
        table.insert(mason_servers, server)
    else
        vim.lsp.enable(server)
    end
end

if ok_mason_map and mason_map.rust_analyzer then
    table.insert(mason_servers, 'rust_analyzer')
end
table.sort(mason_servers)

require('mason-lspconfig').setup {
    ensure_installed = mason_servers,
    automatic_enable = {
        exclude = mason_exclude,
    },
}

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('__lsp_attach__', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
            return
        end

        if client.name == 'ruff' then
            client.server_capabilities.hoverProvider = false
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        end
    end,
})
