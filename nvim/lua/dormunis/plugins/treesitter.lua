return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-refactor',
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            refactor = {
                highlight_definitions = {
                    enable = true,
                    clear_on_cursor_move = true,
                },
                highlight_current_scope = {
                    enable = true,
                },
                smart_rename = {
                    enable = true,
                    keymaps = {
                        smart_rename = "<leader>cr",
                    },
                }
            },
            ensure_installed = {
                "c",
                "lua",
                "go",
                "vim",
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
                "markdown_inline"
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
            },
        }
    end
}
