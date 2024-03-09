return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        dependencies = {
            "rktjmp/lush.nvim",
            event = "UiEnter",
        },
        opts = {
            style = "night",
            light_style = "day",
            transparent = false,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                functions = { bold = true },
                variables = {},
                sidebars = "dark",
                floats = "dark",
            },
            sidebars = { "qf", "help" },
            day_brightness = 0.3,
            hide_inactive_statusline = false,
            dim_inactive = false,
            lualine_bold = true,

            on_colors = function(colors)
                colors.bg = "#000000"
                colors.fg = "#ffffff"
            end,
            on_highlights = function(highlights, colors) highlights.Normal = { bg = "#000000", fg = "#ffffff" } end,
        },
    },
}
