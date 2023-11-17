FONT_WIDTH_HEIGHT_RATIO = 1.6

local popup = function(cmd)
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)
    if width / (height * FONT_WIDTH_HEIGHT_RATIO) > 1 then
        cmd = 'vertical ' .. cmd
    end
    vim.cmd(cmd)
end

return {
    'tpope/vim-fugitive',
    event = "VeryLazy",
    config = function()
        vim.api.nvim_win_get_width(0)
        vim.keymap.set("n", "<leader>gs", function()
            if vim.bo.ft ~= "fugitive" then
                popup('Git')
            else
                vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), { force = true })
            end
        end, { desc = 'Git status' })
        vim.keymap.set("n", "<leader>gpl", function() vim.cmd.Git({ 'pull' }) end, { desc = 'Git pull' })
        vim.keymap.set("n", "<leader>gcm", function()
            popup('Git commit')
        end, { desc = 'Git commit' })
        vim.keymap.set("n", "<leader>gd", function() vim.cmd('Gvdiffsplit') end, { desc = 'Git diff' })
    end
}
