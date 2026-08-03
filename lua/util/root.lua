local M = {}

M.markers = {
    '.git',
    'Cargo.toml',
    'CMakeLists.txt',
    'pyproject.toml',
    'package.json',
    'Makefile',
}

function M.get(buf)
    return vim.fs.root(buf or 0, M.markers) or vim.uv.cwd()
end

function M.opts(opts, buf)
    return vim.tbl_extend('force', { cwd = M.get(buf) }, opts or {})
end

return M
