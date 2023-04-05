return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
   dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function ()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = {
                "c",
                "lua",
                "go",
                "vim",
                "help",
                "query",
                "python",
                "javascript",
                "typescript",
                "rust",
                "terraform",
                "arduino",
                "cpp",
                "css",
                "dockerfile",
                "html",
                "json",
                "make",
                "regex",
                "scala",
                "toml",
                "java",
                "sql",
                "bash",
                "yaml",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
            },
        }
    end
}
