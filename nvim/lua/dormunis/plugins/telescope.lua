return {
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = { 'node_modules', 'vendor', '%.git', "%.png", "%.jpg", "%.gif", "%.webp" },
            }
        }
        local builtin = require('telescope.builtin')
        local utils = require('telescope.utils')

        -- project navigation
        vim.keymap.set('n', '<Tab><Tab>', function()
                builtin.find_files({ hidden = true })
            end,
            { desc = 'Find files (filtered to roughly relevant files)' })
        vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = 'Find files in git repo' })
        vim.keymap.set('n', '<leader>gl', builtin.git_commits, { desc = 'Git log (telescope)' })
        vim.keymap.set('n', '<leader>gL', builtin.git_bcommits, { desc = 'Git log for current buffer (telescope)' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find currently running buffers' })
        vim.keymap.set('n', '<leader>fr', function() builtin.oldfiles({ cwd = utils.buffer_dir() }) end,
            { desc = 'Find recently opened files' })
        vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Find in Current buffer' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find Grep on all files from project root' })
        vim.keymap.set('n', '<leader>fw', function()
            builtin.grep_string({ search = vim.fn.expand('<cword>') })
        end, { desc = 'Find Word - fuzzy search word under cursor' })

        -- telescope builtin help
        vim.keymap.set('n', '<leader>hh', builtin.help_tags, { desc = 'Find Help - fuzzy search help' })
        vim.keymap.set('n', '<leader>hk', builtin.keymaps, { desc = 'Find Keymaps - fuzzy search keymaps' })
    end,
}
