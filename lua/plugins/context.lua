return {
    "andersevenrud/nvim_context_vt",
    event = "UiEnter",
    config = function()
        require("nvim_context_vt").setup({
            enabled = true,
            prefix = "->",
            disable_ft = { "markdown" },
            min_rows = 1,
            min_rows_ft = {},
        })
    end,
}
