return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require('rose-pine').setup({
            dim_inactive_windows = false,
            styles = {
                transparency = 0.8,
            }
        })
        vim.cmd("colorscheme rose-pine")
    end
}
