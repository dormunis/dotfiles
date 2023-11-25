return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require("todo-comments").setup {
            vim.keymap.set('n', 'T', '<cmd>TodoTelescope<CR>'),
            -- vim.keymap.set('n', '<leader>tF', '<cmd>TodoQuickFix<CR>'),
        }
    end
}
