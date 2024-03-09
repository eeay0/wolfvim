return {
    "numToStr/Comment.nvim",
    event = "UiEnter",
    config = function()
        require("Comment").setup({
            padding = true,
            sticky = true,
            toggler = { line = "gcc", block = "gbc" },
            opleader = { line = "gc", block = "gb" },
            extra = { above = "gcO", below = "gco", eol = "gcA" },
        })
    end,
}
