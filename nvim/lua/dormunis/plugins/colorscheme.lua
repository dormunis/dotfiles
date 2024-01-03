return {
    "savq/melange-nvim",
    config = function()
        vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
        vim.cmd("colorscheme melange")
    end,
}
