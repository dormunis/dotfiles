return {
    'tpope/vim-fugitive',
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = 'Git status' })
        vim.keymap.set("n", "<leader>gpl", function() vim.cmd.Git({ 'pull' }) end, { desc = 'Git pull' })
        vim.keymap.set("n", "<leader>ga", function()
            local bufnr = vim.api.nvim_get_current_buf();
            local filepath = vim.api.nvim_buf_get_name(bufnr);
            vim.cmd('Git add ' .. filepath)
            vim.notify('Git added: ' .. filepath)
        end, { desc = 'Git add' })
        vim.keymap.set("n", "<leader>gcm", function()
            local message = vim.fn.input('Commit message: ')
            if message ~= '' then
                vim.cmd('Git commit -m "' .. message .. '"')
            else
                vim.notify('Commit message cannot be empty', vim.log.levels.ERROR)
            end
        end, { desc = 'Git commit' })
    end
}
