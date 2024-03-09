local M = {
    "m-demare/hlargs.nvim",
    event = "BufReadPost",
    config = function() require("hlargs").setup() end,
}

return M
