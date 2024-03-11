return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = false, -- disables setting the background color.
            show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
            term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = false, -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15, -- percentage of the shade to apply to the inactive window
            },
            no_italic = false, -- Force no italic
            no_bold = false, -- Force no bold
            no_underline = false, -- Force no underline
            styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" }, -- Change the style of comments
                conditionals = { "italic", "bold" },
                loops = { "italic", "bold" },
                functions = { "bold" },
                keywords = { "italic" },
                strings = { "italic" },
                variables = {},
                numbers = {},
                booleans = { "bold" },
                properties = {},
                types = { "bold" },
                operators = {},
                -- miscs = {}, -- Uncomment to turn off hard-coded styles
            },
            color_overrides = {},
            custom_highlights = {},
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                noice = true,
                flash = true,
                harpoon = true,
                indent_blankline = {
                    enabled = true,
                    scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                    colored_indent_levels = true,
                },
                lsp_saga = true,
                mason = true,
                ts_rainbow = true,
                rainbow_delimiters = true,
                telescope = {
                    enabled = true,
                    style = "nvchad",
                },
                lsp_trouble = true,
                illuminate = {
                    enabled = true,
                    lsp = false,
                },
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },

                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
        })

        -- setup must be called before loading
        vim.cmd.colorscheme("catppuccin")
    end,
}
