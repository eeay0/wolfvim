return {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        local tsj = require("treesj")
        local langs = {}
        tsj.setup({
            use_default_keymaps = true,
            check_syntax_error = true,
            max_join_length = 120,
            cursor_behavior = "hold",
            notify = false,
            dot_repeat = true,
            on_error = nil,
        })
    end,
}
