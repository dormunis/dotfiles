return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup({})

        -- configure telescope
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>fh", function() toggle_telescope(harpoon:list()) end,
            { desc = "Open harpoon window" })
        vim.keymap.set("n", "<leader>fm", function()
            harpoon:list():append()
            vim.notify("Marked current file", vim.log.levels.INFO)
        end, { desc = "Mark current file" })
        vim.keymap.set("n", "<C-P>", function() harpoon:list():prev() end,
            { desc = "Navigate to previous marked file" })
        vim.keymap.set("n", "<C-N>", function() harpoon:list():next() end, { desc = "Navigate to next marked file" })
    end,
}
