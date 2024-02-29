return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local trouble = require("trouble")
        trouble.setup({
            icons = false,
        })

        local opts = function(table)
            local result = {}
            for k, v in pairs(table) do
                result[k] = v
            end
            result.noremap = true
            result.silent = true
            return result
        end

        vim.keymap.set("n", "<leader>xx", function()
            trouble.toggle({ mode = "document_diagnostics" })
        end, opts({ desc = "Toggle trouble" }))
        vim.keymap.set("n", "<leader>xw", function()
            trouble.toggle({ mode = "workspace_diagnostics" })
        end, opts({ desc = "Toggle trouble" }))
        vim.keymap.set("n", "]x", function()
            vim.diagnostic.goto_next({ skip_groups = true, jump = true })
            -- trouble.next({ skip_groups = true, jump = true })
        end, opts({ desc = "Next diagnostic" }))
        vim.keymap.set("n", "[x", function()
            -- trouble.previous({ skip_groups = true, jump = true })
            vim.diagnostic.goto_prev({ skip_groups = true, jump = true })
        end, opts({ desc = "Previous diagnostic" }))
        vim.keymap.set("n", "X", vim.diagnostic.open_float, opts({ desc = "Open diagnostics for current line" }))

        vim.diagnostic.config({
            title = false,
            underline = true,
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            severity_sort = true,
        })
    end,
}
