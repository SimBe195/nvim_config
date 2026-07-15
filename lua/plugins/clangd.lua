return {
    {
        'neovim/nvim-lspconfig',
        opts = {
            setup = {
                clangd = function(_, opts)
                    opts.cmd = {
                        'clangd',
                        '--query-driver=/usr/bin/g++,/usr/bin/gcc,/usr/bin/c++,/usr/bin/cc',
                    }
                end,
            },
        },
    },
}
