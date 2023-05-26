return {
    'mfussenegger/nvim-dap',
    dependencies = {
        "mfussenegger/nvim-dap-python",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dap = require("dap")
        -- keybindings
        vim.keymap.set('n', '<F1>', function() dap.continue() end, { desc = "Debug: continue" })
        vim.keymap.set('n', '<F2>', function() dap.step_over() end, { desc = "Debug: step over" })
        vim.keymap.set('n', '<F3>', function() dap.step_into() end, { desc = "Debug: step into" })
        vim.keymap.set('n', '<F4>', function() dap.step_out() end, { desc = "Debug: step out" })
        vim.keymap.set('n', '<C-t>', function() dap.toggle_breakpoint() end, { desc = "Debug: toggle breakpoint" })
        vim.keymap.set('n', '<leader>dc',
            function() dap.set_breakpoint(vim.fn.input('Breakpoint point message: ')) end,
            { desc = "Debug: conditional breakpoint" })
        vim.keymap.set('n', '<leader>dl',
            function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
            { desc = "Debug: log point" })
        vim.keymap.set('n', '<leader>do', function() dap.repl.open() end, { desc = "Debug: open REPL" })
        vim.keymap.set('n', '<leader>dr', function() dap.run_last() end, { desc = "Debug: run last" })


        local dapui = require("dapui")
        dapui.setup({})
        -- ui auto-hook
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

        -- extensions
        require("nvim-dap-virtual-text").setup({})

        -- language plugins

        -- python
        local python = require('dap-python')
        python.setup('~/.config/dap-virtualenvs/debugpy/bin/python')

        -- language keybindings
        vim.keymap.set('n', '<leader>df', function()
            local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
            if filetype == 'python' then
                python.test_method()
            end
        end, { desc = "Debug: this test function" }
        )

        vim.keymap.set('n', '<leader>dc', function()
            local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
            if filetype == 'python' then
                python.test_class()
            end
        end, { desc = "Debug: this test class" }
        )
    end
}
