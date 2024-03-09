return {
    "uga-rosa/ccc.nvim",
    event = "UiEnter",
    config = function()
        local ccc = require("ccc")
        local mapping = ccc.mapping

        ccc.setup({
            bar_lenght = 60,
            save_on_quit = true,
            highlighter = {
                auto_enable = true,
                lsp = true,
            },
            inputs = {
                ccc.input.hsl,
                ccc.input.rgb,
                ccc.input.cmyk,
            },
            outputs = {
                ccc.output.hsl,
                ccc.output.css_hsl,
                ccc.output.css_rgb,
                ccc.output.hex,
                ccc.output.hex_short,
            },
            recognize = {
                input = true,
                output = true,
            },
            mappings = {
                L = mapping.increase5,
                K = mapping.increase10,
                H = mapping.decrease5,
                J = mapping.decrease10,
            },
        })
        --- Keymaps
        vim.keymap.set("n", "<leader>cc", "<cmd>CccPick<cr>", { silent = true })
    end,
}
