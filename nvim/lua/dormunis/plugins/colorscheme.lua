-- return {
--     "morhetz/gruvbox",
--     name = "gruvbox",
--     config = function()
--         vim.g.gruvbox_contrast_dark = "hard"
--         vim.g.gruvbox_transparent_bg = 1
--         vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
--         vim.cmd.colorscheme("gruvbox")
--     end
-- }
return {
    "fenetikm/falcon",
    config = function()
        vim.g.falcon_background = 0
        vim.cmd.colorscheme("falcon")
    end
}
