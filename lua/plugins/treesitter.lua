return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "UiEnter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "windwp/nvim-ts-autotag",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "markdown", "markdown_inline" },
            sync_install = true,
            auto_install = true,
            highlihght = { enable = true },
            autotag = {
                enable = true,
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
                filetypes = { "html", "xml" },
            },
        })
    end,
}
