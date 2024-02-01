return {
    "morhetz/gruvbox",
    name = "gruvbox",
    config = function()
        vim.g.gruvbox_contrast_dark = "hard"
        vim.g.gruvbox_transparent_bg = 1
        vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
        vim.cmd.colorscheme("gruvbox")
    end
}
