return {
    'tpope/vim-fugitive',
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = 'Git status' })
        vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git({ 'pull' }) end, { desc = 'Git pull' })
    end
}
