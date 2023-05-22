return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('oil').setup()
    end,
    keys = {
        {
            "-",
            function() require('oil').open() end,
            desc = "Open parent directory",
        },
    }
}
