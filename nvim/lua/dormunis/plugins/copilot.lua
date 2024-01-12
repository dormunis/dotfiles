return {
    'github/copilot.vim',
    config = function()
        vim.api.nvim_set_keymap("i", "<S-Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true });
        vim.g.copilot_no_tab_map = true;
    end
}
