return {
    "folke/trouble.nvim",
    depends = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "§",
            function() require('trouble').toggle() end,
            "Toggle Trouble",
        },
    },
}
