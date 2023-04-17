return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>g", function()
        end, { desc = 'Git' })
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = '[G]it [S]tatus w/ Vim Fugitive' })
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

        local fugitive_augroup = vim.api.nvim_create_augroup("fugitive_augroup", {})
        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = fugitive_augroup,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, { buffer = bufnr, remap = false, desc = "[G]it [p]ush" })

                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({ 'pull' })
                end, { buffer = bufnr, remap = false, desc = "[G]it [P]ull" })

                vim.keymap.set("n", "<leader>t", ":Git push -u origin ",
                    { buffer = bufnr, remap = false, desc = "[G]it push -u origin and [t]rack" });
            end,
        })
    end
}
