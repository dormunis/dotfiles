FONT_WIDTH_HEIGHT_RATIO = 2.1

local popup = function(cmd)
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)
    if width / (height * FONT_WIDTH_HEIGHT_RATIO) > 1 then
        cmd = 'vertical ' .. cmd
    end
    vim.cmd(cmd)
end

local function getFugitiveBufferWindowIds()
    local fugitiveBufferIds = {}
    local buffers = vim.api.nvim_list_bufs()
    local fugitivePattern = "fugitive://.*/%d+/.+"

    for _, buf in ipairs(buffers) do
        local name = vim.api.nvim_buf_get_name(buf)
        if string.match(name, fugitivePattern) then
            table.insert(fugitiveBufferIds, buf)
        end
    end

    local fugitiveWindowIds = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.tbl_contains(fugitiveBufferIds, vim.api.nvim_win_get_buf(win)) then
            table.insert(fugitiveWindowIds, win)
        end
    end

    return fugitiveWindowIds
end

return {
    'tpope/vim-fugitive',
    event = "VeryLazy",
    config = function()
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
        vim.keymap.set("n", "<leader>gd", function()
            local fugitiveWindows = getFugitiveBufferWindowIds()
            if #fugitiveWindows > 0 then
                for _, win in ipairs(fugitiveWindows) do
                    vim.api.nvim_win_close(win, false)
                end
            else
                vim.cmd('Gvdiffsplit!')
            end
        end, { desc = 'Git diff' })
    end
}
