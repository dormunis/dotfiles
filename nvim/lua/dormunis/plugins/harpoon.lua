return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        {
            "<leader>fa",
            function() require('harpoon.mark').add_file() end,
            desc = "[F]ile [A]dd to quick access menu (using Harpoon)",
        },
        {
            "<leader>fq",
            function() require('harpoon.ui').toggle_quick_menu() end,
            desc = "[F]ile [Q]uick menu (using Harpoon)",
        },
        {
            "<leader>f1",
            function() require('harpoon.ui').nav_file(1) end,
            desc = "go to quick file #1"
        },
        {
            "<leader>f2",
            function() require('harpoon.ui').nav_file(2) end,
            desc = "go to quick file #2",
        },
        {
            "<leader>f3",
            function() require('harpoon.ui').nav_file(3) end,
            desc = "go to quick file #3"
        },
        {
            "<leader>f4",
            function() require('harpoon.ui').nav_file(4) end,
            desc = "go to quick file #4",
        },
    },
}
