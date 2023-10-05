return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-refactor',
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup {
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    scope_incremental = '<CR>',
                    node_incremental = '<TAB>',
                    node_decremental = '<S-TAB>',
                },
            },
            refactor = {
                highlight_definitions = {
                    enable = true,
                    clear_on_cursor_move = true,
                },
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
            indent = { enable = true },
            highlight = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['aa'] = { query = '@parameter.outer', desc = 'Select around parameter' },
                        ['ia'] = { query = '@parameter.inner', desc = 'Select inside parameter' },
                        ['af'] = { query = '@function.outer', desc = 'Select around function' },
                        ['if'] = { query = '@function.inner', desc = 'Select inside function' },
                        ['ac'] = { query = '@class.outer', desc = 'Select around class' },
                        ['ic'] = { query = '@class.inner', desc = 'Select inside class' },
                        ['ai'] = { query = '@conditional.outer', desc = 'Select around conditional' },
                        ['ii'] = { query = '@conditional.inner', desc = 'Select inside conditional' },
                        ['al'] = { query = '@loop.outer', desc = 'Select around loop' },
                        ['il'] = { query = '@loop.inner', desc = 'Select inside loop' },
                        ['a='] = { query = '@assignment.outer', desc = 'Select entire assignment' },
                        ['i='] = { query = '@assignment.inner', desc = 'Select assignment value' },
                        ['v='] = { query = '@assignment.lhs', desc = 'Select assignment variable' },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                }
            },
        }
    end
}
