return {
    "RRethy/vim-illuminate",
    event = "UiEnter",
    config = function()
        require("illuminate").configure({
            providers = {
                "lsp",
                "treesitter",
                "regex",
            },
            delay = 100,
            filetype_overrides = {},
            filetypes_denylist = {
                "dirbuf",
                "dirvish",
                "fugitive",
                "markdown",
            },
            under_cursor = true,
        })
    end,
}
