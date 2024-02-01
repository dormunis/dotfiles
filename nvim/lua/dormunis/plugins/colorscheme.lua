-- return {
--     "ellisonleao/gruvbox.nvim",
--     config = function()
--         vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
--         require("gruvbox").setup({
--             transparent_mode = true
--         })
--         vim.cmd("colorscheme gruvbox")
--     end,
-- }
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
