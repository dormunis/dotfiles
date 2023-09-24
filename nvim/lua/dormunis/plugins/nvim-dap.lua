local nmap = function(key, fn, desc)
    vim.keymap.set('n', key, fn, { desc = desc })
end

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
        nmap('<leader>dr', function() dap.continue() end, { desc = "Debug: continue" })
        nmap('<leader>dso', function() dap.step_over() end, { desc = "Debug: step over" })
        nmap('<leader>dsi', function() dap.step_into() end, { desc = "Debug: step into" })
        nmap('<leader>dsb', function() dap.step_out() end, { desc = "Debug: step out/back" })
        nmap('<leader>db', function() dap.toggle_breakpoint() end, { desc = "Debug: toggle breakpoint" })
        nmap('<leader>dc',
            function() dap.set_breakpoint(vim.fn.input('Breakpoint point message: ')) end,
            { desc = "Debug: conditional breakpoint" })
        nmap('<leader>dl',
            function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
            { desc = "Debug: log point" })


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
        nmap('<leader>df', function()
            local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
            if filetype == 'python' then
                python.test_method()
            end
        end, { desc = "Debug: this test function" }
        )

        nmap('<leader>dc', function()
            local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
            if filetype == 'python' then
                python.test_class()
            end
        end, { desc = "Debug: this test class" }
        )
    end
}
