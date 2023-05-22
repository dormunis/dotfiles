return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('oil').setup()
        vim.keymap.set('n', '-', require('oil').open, { desc = "Open parent directory" })
    end
}
