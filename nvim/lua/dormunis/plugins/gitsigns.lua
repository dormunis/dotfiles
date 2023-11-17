return {
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
                map('v', '<leader>ga',
                    function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = "Git: Reset hunk" })
                map('v', '<leader>gr',
                    function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = "Git: Reset hunk" })
                map('n', '<leader>gA', gs.stage_buffer, { desc = "Git: Stage buffer" })
                map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Git: Undo stage" })
                map('n', '<leader>gR', gs.reset_buffer, { desc = "Git: Reset buffer" })
                map('n', '<leader>gp', gs.preview_hunk, { desc = "Git: Preview hunk" })
                map('n', '<leader>gB', function() gs.blame_line {} end,
                    { desc = "Git: full git blame on line" })
                map('n', '<leader>gb', gs.toggle_current_line_blame, { desc = "Git: toggle blame on line" })
                map('n', '<leader>gd', gs.diffthis, { desc = "Git: diff" })
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
