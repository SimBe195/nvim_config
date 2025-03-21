return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            cmake = { 'cmake_format' },
            cpp = { 'clang-format' },
        },
    },
}
