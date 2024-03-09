return {
    "folke/flash.nvim",
    event = "UiEnter",
    config = function()
        require("flash").setup({
            labels = "asdfghjklqwertyuiopzxcvbnm",
            search = {
                multi_window = true,
                forward = true,
                wrap = true,
                mode = "fuzzy",
                incremental = false,
                exclude = {
                    "notify",
                    "cmp_menu",
                    "noice",
                    "flash_prompt",
                    function(win) return not vim.api.nvim_win_get_config(win).focusable end,
                },
                trigger = "",
                max_length = false, ---@type number|false
            },
            jump = {
                jumplist = true,
                pos = "start", ---@type "start" | "end" | "range"
                history = false,
                register = false,
                nohlsearch = false,
                autojump = true,
                inclusive = nil, ---@type boolean?
                offset = nil, ---@type number
            },
            label = {
                uppercase = true,
                exclude = "",
                current = true,
                after = true, ---@type boolean|number[]
                before = true, ---@type boolean|number[]
                style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
                reuse = "lowercase", ---@type "lowercase" | "all" | "none"
                distance = true,
                min_pattern_length = 0,
                rainbow = {
                    enabled = true,
                    shade = 9,
                },
                ---@class Flash.Format
                ---@field state Flash.State
                ---@field match Flash.Match
                ---@field hl_group string
                ---@field after boolean
                ---@type fun(opts:Flash.Format): string[][]
                format = function(opts) return { { opts.match.label, opts.hl_group } } end,
            },
            highlight = {
                backdrop = true,
                matches = true,
                priority = 5000,
                groups = {
                    match = "FlashMatch",
                    current = "FlashCurrent",
                    backdrop = "FlashBackdrop",
                    label = "FlashLabel",
                },
            },
            ---@type fun(match:Flash.Match, state:Flash.State)|nil
            action = nil,
            -- initial pattern to use when opening flash
            pattern = "",
            -- When `true`, flash will try to continue the last search
            continue = false,
            -- Set config to a function to dynamically change the config
            config = nil, ---@type fun(opts:Flash.Config)|nil
            -- You can override the default options for a specific mode.
            -- Use it with `require("flash").jump({mode = "forward"})`
            ---@type table<string, Flash.Config>
            modes = {
                -- options used when flash is activated through
                -- a regular search with `/` or `?`
                search = {
                    -- when `true`, flash will be activated during regular search by default.
                    -- You can always toggle when searching with `require("flash").toggle()`
                    enabled = true,
                    highlight = { backdrop = false },
                    jump = { history = true, register = true, nohlsearch = true },
                    search = {
                        -- `forward` will be automatically set to the search direction
                        -- `mode` is always set to `search`
                        -- `incremental` is set to `true` when `incsearch` is enabled
                    },
                },
                -- options used when flash is activated through
                -- `f`, `F`, `t`, `T`, `;` and `,` motions
                char = {
                    enabled = true,
                    -- dynamic configuration for ftFT motions
                    config = function(opts)
                        -- autohide flash when in operator-pending mode
                        opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")

                        -- disable jump labels when not enabled, when using a count,
                        -- or when recording/executing registers
                        opts.jump_labels = opts.jump_labels
                            and vim.v.count == 0
                            and vim.fn.reg_executing() == ""
                            and vim.fn.reg_recording() == ""

                        -- Show jump labels only in operator-pending mode
                        -- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
                    end,
                    -- hide after jump when not using jump labels
                    autohide = false,
                    -- show jump labels
                    jump_labels = false,
                    -- set to `false` to use the current line only
                    multi_line = true,
                    -- When using jump labels, don't use these keys
                    -- This allows using those keys directly after the motion
                    label = { exclude = "hjkliardc" },
                    -- by default all keymaps are enabled, but you can disable some of them,
                    -- by removing them from the list.
                    -- If you rather use another key, you can map them
                    -- to something else, e.g., { [";"] = "L", [","] = H }
                    keys = { "f", "F", "t", "T", ";", "," },
                    ---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
                    -- The direction for `prev` and `next` is determined by the motion.
                    -- `left` and `right` are always left and right.
                    char_actions = function(motion)
                        return {
                            [";"] = "next", -- set to `right` to always go right
                            [","] = "prev", -- set to `left` to always go left
                            -- clever-f style
                            [motion:lower()] = "next",
                            [motion:upper()] = "prev",
                            -- jump2d style: same case goes next, opposite case goes prev
                            -- [motion] = "next",
                            -- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
                        }
                    end,
                    search = { wrap = false },
                    highlight = { backdrop = true },
                    jump = { register = false },
                },
                -- options used for treesitter selections
                -- `require("flash").treesitter()`
                treesitter = {
                    labels = "abcdefghijklmnopqrstuvwxyz",
                    jump = { pos = "range" },
                    search = { incremental = false },
                    label = { before = true, after = true, style = "inline" },
                    highlight = {
                        backdrop = false,
                        matches = false,
                    },
                },
                treesitter_search = {
                    jump = { pos = "range" },
                    search = { multi_window = true, wrap = true, incremental = false },
                    remote_op = { restore = true },
                    label = { before = true, after = true, style = "inline" },
                },
                -- options used for remote flash
                remote = {
                    remote_op = { restore = true, motion = true },
                },
            },
            -- options for the floating window that shows the prompt,
            -- for regular jumps
            prompt = {
                enabled = true,
                prefix = { { "⚡", "FlashPromptIcon" } },
                win_config = {
                    relative = "editor",
                    width = 1, -- when <=1 it's a percentage of the editor width
                    height = 1,
                    row = -1, -- when negative it's an offset from the bottom
                    col = 0, -- when negative it's an offset from the right
                    zindex = 1000,
                },
            },
            -- options for remote operator pending mode
            remote_op = {
                -- restore window views and cursor position
                -- after doing a remote operation
                restore = false,
                -- For `jump.pos = "range"`, this setting is ignored.
                -- `true`: always enter a new motion when doing a remote operation
                -- `false`: use the window's cursor position and jump target
                -- `nil`: act as `true` for remote windows, `false` for the current window
                motion = false,
            },
        })

        local flash = require("flash")
        --- keys
        vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end)
        vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end)
        vim.keymap.set({ "n", "x", "o" }, "R", function() flash.jump() end)
        vim.keymap.set({ "c" }, "<c-s>", function() flash.toggle() end)
    end,
}
