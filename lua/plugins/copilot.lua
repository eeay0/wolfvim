local M = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    --- test for coplit. say hi

    config = function()
        require("copilot").setup({
            panel = {
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<leader>ca",
                    refresh = "<A-r>",
                    open = "<A-CR>",
                },
                layout = {
                    position = "bottom", -- | top | left | right
                    ratio = 0.4,
                },
            },
            suggestion = {
                debounce = 50,
                keymap = {
                    accept = "<A-a>",
                    accept_word = "<A-w>",
                    accept_line = "<A-l>",
                    next = "<A-]>",
                    prev = "<A-[>",
                    dismiss = "<C-]>",
                },
            },
            filetypes = {
                yaml = true,
            },
            copilot_node_command = "node", -- Node.js version must be > 18.x
            server_opts_overrides = {},
        })
    end,
}

return M
