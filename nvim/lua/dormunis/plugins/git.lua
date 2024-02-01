FONT_WIDTH_HEIGHT_RATIO = 2.1

local popup = function(cmd)
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)
    if width / (height * FONT_WIDTH_HEIGHT_RATIO) > 1 then
        cmd = 'vertical ' .. cmd
    end
    vim.cmd(cmd)
end

local function getFugitiveBufferWindowIds()
    local fugitiveBufferIds = {}
    local buffers = vim.api.nvim_list_bufs()
    local fugitivePattern = "fugitive://.*/%d+/.+"

    for _, buf in ipairs(buffers) do
        local name = vim.api.nvim_buf_get_name(buf)
        if string.match(name, fugitivePattern) then
            table.insert(fugitiveBufferIds, buf)
        end
    end

    local fugitiveWindowIds = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.tbl_contains(fugitiveBufferIds, vim.api.nvim_win_get_buf(win)) then
            table.insert(fugitiveWindowIds, win)
        end
    end

    return fugitiveWindowIds
end

return {
    {
        'tpope/vim-fugitive',
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>gs", function()
                if vim.bo.ft ~= "fugitive" then
                    popup('Git')
                else
                    vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), { force = true })
                end
            end, { desc = 'Git status' })

            vim.keymap.set("n", "<leader>gpl", function() vim.cmd.Git({ 'pull' }) end, { desc = 'Git pull' })
            vim.keymap.set('n', '<leader>gb', function()
                    if vim.bo.ft ~= "fugitiveblame" then
                        vim.cmd.Git({ 'blame' })
                    else
                        vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), { force = true })
                    end
                end,
                { desc = "Git: git blame on file" })
            vim.keymap.set("n", "<leader>gcm", function()
                popup('Git commit')
            end, { desc = 'Git commit' })
            vim.keymap.set("n", "<leader>gd", function()
                local fugitiveWindows = getFugitiveBufferWindowIds()
                if #fugitiveWindows > 0 then
                    for _, win in ipairs(fugitiveWindows) do
                        vim.api.nvim_win_close(win, false)
                    end
                else
                    vim.cmd('Gvdiffsplit!')
                end
            end, { desc = 'Git diff' })
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        event = "VeryLazy",
        config = function()
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'Git: Next Hunk' })

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'Git: Previous Hunk' })

                    -- Actions
                    map('n', '<leader>ga', gs.stage_hunk, { desc = "Git: Stage hunk" })
                    map('n', '<leader>gr', gs.reset_hunk, { desc = "Git: Reset hunk" })
                    map('v', '<leader>gA',
                        function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = "Git: Reset hunk" })
                    map('v', '<leader>gr',
                        function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = "Git: Reset hunk" })
                    map('n', '<leader>ga', function()
                        gs.stage_buffer()
                        local filepath = vim.api.nvim_buf_get_name(bufnr)
                        vim.notify('Git added: ' .. filepath)
                    end, { desc = "Git: Stage buffer" })
                    map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Git: Undo stage" })
                    map('n', '<leader>gR', gs.reset_buffer, { desc = "Git: Reset buffer" })
                    map('n', '<leader>gp', gs.preview_hunk, { desc = "Git: Preview hunk" })
                    map('n', '<leader>gB', gs.blame_line, { desc = "Git: toggle blame on line" })

                    -- Text objects
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gisigns select_hunk<CR>')
                end
            }
        end,
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    }
}
