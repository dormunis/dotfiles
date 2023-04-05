return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>g", function()
        end, { desc = 'Git' })
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = '[G]it [S]tatus w/ Vim Fugitive' })
    end
}
