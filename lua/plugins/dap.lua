return {
    "mfussenegger/nvim-dap",
    event = "UiEnter",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        require("dapui").setup()
        require("nvim-dap-virtual-text").setup({
            highlight_changed_variables = true,
            highlight_new_as_changed = true,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = true,
            clear_on_continue = false,
            --virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
            virt_text_pos = "eol",
        })

        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })

        require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

        local dap = require("dap")
        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "-i", "dap" },
        }

        dap.configurations.c = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function() return vim.fn.input("/bin/gdb", vim.fn.getcwd() .. "/", "file") end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
        }
    end,
}
