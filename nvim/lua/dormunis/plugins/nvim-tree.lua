return {
    "nvim-tree/nvim-tree.lua",
    keys = {
        -- { "<leader>e", ":NvimTreeFindFileToggle<CR>", desc = "Toggle NvimTree" },
        { "<leader>e", function() require("nvim-tree.api").tree.toggle() end, desc = "Toggle NvimTree" },
    },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            filters = {
                dotfiles = true,
            },
        })
    end
}
