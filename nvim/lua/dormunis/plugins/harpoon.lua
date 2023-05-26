return {
    'dormunis/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        {
            "<C-a>",
            function() require('harpoon.mark').add_file() end,
            desc = "[F]ile [A]dd to quick access menu (using Harpoon)",
        },
        {
            "<C-p>",
            function() require('harpoon.ui').toggle_quick_menu() end,
            desc = "[F]ile [Q]uick menu (using Harpoon)",
        },
        {
            "{",
            function() require('harpoon.ui').nav_prev() end,
            desc = "Navigate to previous harpoon item"
        },
        {
            "{",
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
    },
}
