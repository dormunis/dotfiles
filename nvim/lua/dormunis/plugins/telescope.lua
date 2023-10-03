return {
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = { 'node_modules', 'vendor', '.git' },
            }
        }
        local builtin = require('telescope.builtin')

        -- project navigation
        vim.keymap.set('n', '<Tab><Tab>', builtin.find_files, { desc = 'Find files from project root' })
        vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = '[F]ind [f]iles in git repo' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind currently running [b]uffers' })
        vim.keymap.set('n', '<leader>f?', require('telescope.builtin').oldfiles,
            { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = '[F]ind in [C]urrent buffer' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind [G]rep on all files from project root' })
        vim.keymap.set('n', '<leader>fw', function()
            builtin.grep_string({ search = vim.fn.expand('<cword>') })
        end, { desc = '[F]ind [W]ord - fuzzy search word under cursor' })

        -- telescope builtin help
        vim.keymap.set('n', '<leader>hh', builtin.help_tags, { desc = '[F]ind [H]elp - fuzzy search help' })
        vim.keymap.set('n', '<leader>hk', builtin.keymaps, { desc = '[F]ind [K]eymaps - fuzzy search keymaps' })
    end,
}
