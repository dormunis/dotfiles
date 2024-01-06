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

        vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end, opts({ desc = "Toggle trouble" }))
        vim.keymap.set("n", "]x", function() trouble.next({ skip_groups = true, jump = true }) end,
            opts({ desc = "Next diagnostic" }))
        vim.keymap.set("n", "[x", function() trouble.previous({ skip_groups = true, jump = true }) end,
            opts({ desc = "Previous diagnostic" }))
        vim.keymap.set('n', 'X', vim.diagnostic.open_float, opts({ desc = "Open diagnostics for current line" }))
        vim.keymap.set('n', '<leader>xl', function() trouble.toggle("loclist") end,
            opts({ desc = "Open location list for diagnostics" }))
    end
}
