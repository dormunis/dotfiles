return {
    "sainnhe/gruvbox-material",
    config = function()
        vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
        vim.cmd("let g:gruvbox_material_background = 'medium'")
        vim.cmd("let g:gruvbox_material_better_performance = 1")
        vim.cmd("let g:gruvbox_material_transparent_background = 2")
        vim.cmd("let g:gruvbox_material_dim_inactive_windows = 1")
        vim.cmd("let g:gruvbox_material_float_style = 'dim'")
        vim.cmd("colorscheme gruvbox-material")
    end,
}
