return {
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
                lualine_b = { "filename" },
                lualine_c = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic", "coc" },
                        sections = { "error", "warn", "info", "hint" },
                        diagnostics_color = {
                            error = "DiagnosticError", -- Changes diagnostics' error color.
                            warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
                            info = "DiagnosticInfo", -- Changes diagnostics' info color.
                            hint = "DiagnosticHint", -- Changes diagnostics' hint color.
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
}
