return {
    'tpope/vim-fugitive',
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = 'Git status' })
        vim.keymap.set("n", "<leader>gp", vim.cmd.Git({ 'pull' }), { desc = 'Git pull' })
    end
}
