return {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {},
    config = function()
        require("ibl").setup {
            indent = { char = "┊" },
            scope = {
                enabled = true,
                show_exact_scope = true,
                highlight = { "Function", "Label" },
            },
        }
    end
}
