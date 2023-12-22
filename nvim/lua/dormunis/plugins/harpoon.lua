return {
    'ThePrimeagen/harpoon',
    keys = {
        {
            "=f",
            function() require("harpoon.mark").add_file() end,
            desc = "Mark current file",
        },
        {
            "+",
            function() require("harpoon.ui").toggle_quick_menu() end,
            desc = "Open harpoon window",
        },
        {
            "==",
            function() require("harpoon.ui").nav_next() end,
            desc = "Navigate to next marked file",
        },
        {
            "=+",
            function() require("harpoon.ui").nav_prev() end,
            desc = "Navigate to next marked file",
        },
    }
}
