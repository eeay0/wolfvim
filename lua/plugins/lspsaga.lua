local M = {
    "nvimdev/lspsaga.nvim",
    event = { "LspAttach" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function() require("lspsaga").setup({}) end,
}
return M
