return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>f', function()
        end, { desc = 'File actions' })
        vim.keymap.set('n', '<leader>f?', require('telescope.builtin').oldfiles,
            { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles from project root' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind [G]rep on all files from project root' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp - fuzzy search help' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = '[C-p] Find files in git repo' })
        vim.keymap.set('n', '<leader>fw', function()
            builtin.grep_string({ search = vim.fn.expand('<cword>') })
        end, { desc = '[F]ind [W]ord - fuzzy search word under cursor' })
    end
}
