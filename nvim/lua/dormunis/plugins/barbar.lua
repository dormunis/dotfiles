-- TODO: integrate tmux and possibly remove this
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
        map("n", "<leader>b[", "<cmd>BufferPrevious<CR>", opts)
        map("n", "<leader>b]", "<cmd>BufferNext<CR>", opts)

        map("n", "<leader>b1", "<cmd>BufferGoto 1<CR>", opts)
        map("n", "<leader>b2", "<cmd>BufferGoto 2<CR>", opts)
        map("n", "<leader>b3", "<cmd>BufferGoto 3<CR>", opts)
        map("n", "<leader>b4", "<cmd>BufferGoto 4<CR>", opts)
        map("n", "<leader>b5", "<cmd>BufferGoto 5<CR>", opts)
        map("n", "<leader>b6", "<cmd>BufferGoto 6<CR>", opts)
        map("n", "<leader>b7", "<cmd>BufferGoto 7<CR>", opts)
        map("n", "<leader>b8", "<cmd>BufferGoto 8<CR>", opts)
        map("n", "<leader>b9", "<cmd>BufferGoto 9<CR>", opts)

        map("n", "<leader>bp", "<cmd>BufferPin<CR>", opts)

        map("n", "<leader>bx", "<cmd>BufferClose<CR>", opts)
        map("n", "<leader>bX", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", opts)
    end,
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
