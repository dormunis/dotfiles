return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    fmt = string.lower,
                },
                sections = {
                    lualine_a = { "branch" },
                    lualine_b = {
                        {
                            "filename",
                            path = 1,
                        }
                    },
                    lualine_c = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic", "coc" },
                            sections = { "error", "warn", "info", "hint" },
                            diagnostics_color = {
                                error = "DiagnosticError",
                                warn = "DiagnosticWarn",
                                info = "DiagnosticInfo",
                                hint = "DiagnosticHint",
                            },
                            symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                            colored = true,
                            update_in_insert = false,
                            always_visible = false,
                        },
                    },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },
    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300

            local wk = require('which-key')
            wk.setup({})
            wk.register({
                f = { name = 'Find' },
                h = { name = 'Help' },
            })
        end,
    },
}
