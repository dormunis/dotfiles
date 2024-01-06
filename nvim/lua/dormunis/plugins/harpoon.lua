return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                save_on_change = true,
            },
        })

        vim.keymap.set("n", "<leader>fh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Open harpoon window" })
        vim.keymap.set("n", "<leader>fm", function()
            harpoon:list():append()
            vim.notify("Marked current file", vim.log.levels.INFO)
        end, { desc = "Mark current file" })
        vim.keymap.set("n", "+", function() harpoon:list():prev({ ui_nav_wrap = true }) end,
            { desc = "Navigate to previous marked file", silent = true, noremap = true })
        vim.keymap.set("n", "=", function() harpoon:list():next({ ui_nav_wrap = true }) end,
            { desc = "Navigate to next marked file", silent = true, noremap = true })
    end,
}
