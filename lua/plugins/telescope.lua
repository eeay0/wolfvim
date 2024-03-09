return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-lua/plenary.nvim",
        "ahmedkhalf/project.nvim",
        "debugloop/telescope-undo.nvim",
    },
    event = "UiEnter",
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "node_modules" },
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                path_display = { "truncate" },
                winblend = 0,
                border = {},
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                -- Developer configurations: Not meant for general override
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                mappings = {
                    n = { ["q"] = require("telescope.actions").close },
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
                extension = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            },
        })
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("projects")
        require("telescope").load_extension("undo")

        require("project_nvim").setup({
            manual_mode = false,
            detection_methods = { "lsp", "pattern" },
            patterns = {
                ".git",
                "_darcs",
                ".hg",
                ".bzr",
                ".svn",
                "Makefile",
                "package.json",
                "stylua.toml",
            },
            ignore_lsp = {},
            exclude_dirs = {
                "~/.cargo/*",
                "~/.cache/*",
                "~/.local/*",
                "~/.mozilla/*",
                "~/.ollama/*",
                "~/.rustup/*",
                "~/upload/*",
            },
            show_hidden = false,
            silent_chdir = false,
            scope_chdir = "global",
            datapath = vim.fn.stdpath("data"),
        })

        --- Keymaps
        local builtin = require("telescope.builtin")
        local extension = require("telescope").extensions
        vim.keymap.set("n", "<A-o>", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>fp", "<cmd> Telescope projects<CR>", { silent = true })
        vim.keymap.set("n", "<leader>fu", "<cmd> Telescope undo <CR>")
    end,
}
