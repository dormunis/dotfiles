return { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        {
            'L3MON4D3/LuaSnip',
            version = "2.*",
            build = "make install_jsregexp"
        },
        'saadparwaiz1/cmp_luasnip'
    },
}
