vim.api.nvim_create_user_command('FormatDisable', function(args)
    if args.bang then
        vim.g.autoformat = false
        vim.notify 'Format-on-save disabled globally'
    else
        vim.b.autoformat = false
        vim.notify 'Format-on-save disabled for this buffer'
    end
end, {
    bang = true,
    desc = 'Disable format-on-save for the current buffer, or globally with !',
})

vim.api.nvim_create_user_command('FormatEnable', function(args)
    if args.bang then
        vim.g.autoformat = true
        vim.notify 'Format-on-save enabled globally'
    else
        vim.b.autoformat = true
        vim.notify 'Format-on-save enabled for this buffer'
    end
end, {
    bang = true,
    desc = 'Enable format-on-save for the current buffer, or globally with !',
})

vim.api.nvim_create_user_command('FormatToggle', function(args)
    if args.bang then
        local enabled = vim.g.autoformat == false
        vim.g.autoformat = enabled
        vim.notify(('Format-on-save %s globally'):format(enabled and 'enabled' or 'disabled'))
    else
        local enabled = vim.b.autoformat == false
        vim.b.autoformat = enabled
        vim.notify(('Format-on-save %s for this buffer'):format(enabled and 'enabled' or 'disabled'))
    end
end, {
    bang = true,
    desc = 'Toggle format-on-save for the current buffer, or globally with !',
})

vim.api.nvim_create_user_command('TmuxHealth', function()
    local ok, lines = require('util.tmux').health()
    local level = ok and vim.log.levels.INFO or vim.log.levels.WARN
    vim.notify(table.concat(lines, '\n'), level, { title = 'Tmux health' })
end, {
    desc = 'Check tmux visibility from this Neovim process',
})
