return {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    opt = {},
    keys = {
        { "<leader>tr", "<cmd>TroubleToggle<cr>",                       desc = "Toggle [T][r]ouble" },
        { "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "[T]rouble [L]ist" },
        { "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "[T]rouble [L]ist" },
        { "<leader>tl", "<cmd>TroubleToggle loclist<cr>",               desc = "[T]rouble [L]ocal list" },
        { "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",              desc = "[T]rouble [Q]uickfix" },
        { "<leader>ts", "<cmd>TroubleToggle lsp_references<cr>",        desc = "[T]rouble L[S]P References" },
    },
}
