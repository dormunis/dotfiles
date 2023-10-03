return {
    'dormunis/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        {
            "<leader>ha",
            function() require('harpoon.mark').add_file() end,
            desc = "Add file to quick access menu",
        },
        {
            "<leader>hh",
            function() require('harpoon.ui').toggle_quick_menu() end,
            desc = "File quick menu",
        },
        {
            "{",
            function() require('harpoon.ui').nav_prev() end,
            desc = "Navigate to previous harpoon item"
        },
        {
            "}",
            function() require('harpoon.ui').nav_next() end,
            desc = "Navigate to next harpoon item"
        },
        {
            "1f",
            function() require('harpoon.ui').nav_file(1) end,
            desc = "go to quick file #1"
        },
        {
            "2f",
            function() require('harpoon.ui').nav_file(2) end,
            desc = "go to quick file #2",
        },
        {
            "3f",
            function() require('harpoon.ui').nav_file(3) end,
            desc = "go to quick file #3"
        },
        {
            "4f",
            function() require('harpoon.ui').nav_file(4) end,
            desc = "go to quick file #4",
        },
        {
            "5f",
            function() require('harpoon.ui').nav_file(5) end,
            desc = "go to quick file #5",
        },
    },
}
