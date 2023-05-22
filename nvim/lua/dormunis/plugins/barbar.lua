return {
    'romgrk/barbar.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        insert_at_start = true,
        animation = true,
    },
    config = function()
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<leader>b", function()
        end, { desc = "Buffer actions" })
        map("n", "{", "<cmd>BufferPrevious<CR>", { silent = true })
        map("n", "}", "<cmd>BufferNext<CR>", opts)

        map("n", "1b", "<cmd>BufferGoto 1<CR>", opts)
        map("n", "2b", "<cmd>BufferGoto 2<CR>", opts)
        map("n", "3b", "<cmd>BufferGoto 3<CR>", opts)
        map("n", "4b", "<cmd>BufferGoto 4<CR>", opts)
        map("n", "5b", "<cmd>BufferGoto 5<CR>", opts)
        map("n", "6b", "<cmd>BufferGoto 6<CR>", opts)
        map("n", "7b", "<cmd>BufferGoto 7<CR>", opts)
        map("n", "8b", "<cmd>BufferGoto 8<CR>", opts)
        map("n", "9b", "<cmd>BufferGoto 9<CR>", opts)

        map("n", "<leader>bp", "<cmd>BufferPin<CR>", opts)

        map("n", "<esc><esc>", "<cmd>BufferClose<CR>", opts)
        map("n", "<leader>bX", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", opts)
    end,
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
