return {
    "vim-test/vim-test",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "preservim/vimux",
    },
    config = function()
        local g = vim.g
        g["test#strategy"] = "vimux"
        g["test#python#pytest#options"] = "-s --disable-warnings"
        g["test#javascript#jest#executable"] = "npm test"
    end,
    keys = {
        {
            "<leader>tt",
            ":TestNearest<CR>",
            desc = "Run current test",
        },
        {
            "<leader>tl",
            ":TestLast<CR>",
            desc = "Run last test",
        },
        {
            "<leader>tf",
            ":TestFile<CR>",
            desc = "Run test file",
        },
        {
            "<leader>ts",
            ":TestSuite<CR>",
            desc = "Run test suite",
        },
        {
            "<leader>tv",
            ":TestVisit<CR>",
            desc = "Jump to last test",
        },
    },
}
