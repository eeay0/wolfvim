local M = {
    "m-demare/hlargs.nvim",
    event = "UiEnter",
    config = function() require("hlargs").setup() end,
}

return M
