vim.keymap.set('n', '<leader>t', function()
end, { desc = 'Todo actions' })

return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require("todo-comments").setup {
            vim.keymap.set('n', '<leader>tt', '<cmd>TodoTelescope<CR>'),
            vim.keymap.set('n', '<leader>tf', '<cmd>TodoQuickFix<CR>'),
        }
    end
}
