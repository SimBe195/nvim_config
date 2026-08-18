local M = {}

M.markers = { '.git' }

function M.get(buf)
    buf = buf or 0
    local cwd = vim.uv.cwd()
    local name = vim.bo[buf].buftype == '' and vim.api.nvim_buf_get_name(buf) or ''
    if name == '' then
        return cwd
    end

    local found = vim.fs.find(M.markers, {
        upward = true,
        path = vim.fs.dirname(name),
        stop = vim.fs.dirname(cwd),
    })[1]

    return found and vim.fs.dirname(found) or cwd
end

function M.opts(opts, buf)
    return vim.tbl_extend('force', { cwd = M.get(buf) }, opts or {})
end

return M
