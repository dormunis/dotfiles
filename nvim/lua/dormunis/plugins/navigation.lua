return {
    {
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
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                    save_on_change = true,
                },
            })

            vim.keymap.set("n", "<leader>fh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { desc = "Open harpoon window" })
            vim.keymap.set("n", "<leader>fm", function()
                harpoon:list():append()
                vim.notify("Marked current file", vim.log.levels.INFO)
            end, { desc = "Mark current file" })
            vim.keymap.set("n", "+", function() harpoon:list():prev({ ui_nav_wrap = true }) end,
                { desc = "Navigate to previous marked file", silent = true, noremap = true })
            vim.keymap.set("n", "=", function() harpoon:list():next({ ui_nav_wrap = true }) end,
                { desc = "Navigate to next marked file", silent = true, noremap = true })
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    }
}
