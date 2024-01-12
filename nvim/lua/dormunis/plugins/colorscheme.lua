return {
    "ellisonleao/gruvbox.nvim",
    config = function()
        vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
        require("gruvbox").setup({
            transparent_mode = true
        })
        vim.cmd("colorscheme gruvbox")
    end,
}
