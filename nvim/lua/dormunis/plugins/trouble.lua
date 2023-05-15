return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        {
            "<leader>tr",
            "<cmd>TroubleToggle<cr>",
            desc =
            "Toggle [T][r]ouble"
        },
        {
            "<leader>tw",
            "<cmd>TroubleToggle workspace_diagnostics<cr>",
            desc =
            "[T]rouble [w]orkspace diagnistics"
        },
        {
            "<leader>td",
            "<cmd>TroubleToggle document_diagnostics<cr>",
            desc =
            "[T]rouble [d]ocument diagnostics"
        },
        {
            "<leader>tq",
            "<cmd>TroubleToggle quickfix<cr>",
            desc =
            "[T]rouble [Q]uickfix"
        },
        {
            "<leader>ts",
            "<cmd>TroubleToggle lsp_references<cr>",
            desc =
            "[T]rouble L[S]P References"
        },
    },
}
