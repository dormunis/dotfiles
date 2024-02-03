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
                show_start = false,
                show_end = false,
                highlight = { "Function", "Label" },
            },
        }
    end
}
