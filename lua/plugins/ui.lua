-- Returns a string with a list of attached LSP clients, including
-- formatters and linters from null-ls, nvim-lint and formatter.nvim

local function get_attached_clients()
    local buf_clients = vim.lsp.get_clients { bufnr = 0 }
    if #buf_clients == 0 then
        return 'LSP Inactive'
    end

    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
        table.insert(buf_client_names, client.name)
    end

    -- This needs to be a string only table so we can use concat below
    local unique_client_names = {}
    for _, client_name_target in ipairs(buf_client_names) do
        local is_duplicate = false
        for _, client_name_compare in ipairs(unique_client_names) do
            if client_name_target == client_name_compare then
                is_duplicate = true
            end
        end
        if not is_duplicate then
            table.insert(unique_client_names, client_name_target)
        end
    end

    local client_names_str = table.concat(unique_client_names, ', ')
    local language_servers = string.format('[%s]', client_names_str)

    return language_servers
end

return {
    {
        'folke/noice.nvim',
        dependencies = { 'MunifTanjim/nui.nvim' },
        opts = {
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false, -- use a classic bottom cmdline for search
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        },
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        opts = {
            flavour = 'mocha',
            transparent_background = false,
            integrations = {
                native_lsp = {
                    virtual_text = {
                        errors = { 'italic' },
                        hints = { 'italic' },
                        warnings = { 'italic' },
                        information = { 'italic' },
                        ok = { 'italic' },
                    },
                    underlines = {
                        errors = { 'underline' },
                        hints = { 'underline' },
                        warnings = { 'underline' },
                        information = { 'underline' },
                        ok = { 'underline' },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
            },
        },
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
        opts = {
            options = {
                separator_style = 'slant', -- Options: "slant", "thick", "thin", etc.
                always_show_bufferline = true,
            },
        },
    },
    {
        'nvim-mini/mini.diff',
        event = 'VeryLazy',
        opts = {
            view = {
                style = 'sign',
                diff_color = {
                    added = { fg = '#98be65' },
                    modified = { fg = '#FF8800' },
                    removed = { fg = '#ec5f67' },
                },
            },
        },
    },
}
