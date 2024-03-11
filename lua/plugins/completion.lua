return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-calc",
            "f3fora/cmp-spell",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-emoji",
            "chrisgrieser/cmp-nerdfont",
        },
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
        },
        {
            "chrisgrieser/nvim-scissors",
            opts = {
                snippetDir = "/home/eeay/src/snippets",
            },
        },
        { "onsails/lspkind.nvim" },
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/home/eeay/src/snippets" } })

        local cmp = require("cmp")
        local lspkind = require("lspkind")
        local luasnip = require("luasnip")

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            snippet = {
                expand = function(args) require("luasnip").lsp_expand(args.body) end,
            },
            view = {
                entries = { name = "custom", selection_order = "near_cursor" },
            },
            window = {
                completion = {
                    scrollbar = true,
                },
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    menu = {
                        buffer = "Buffer",
                        nvim_lsp = "LSP",
                        luasnip = "LuaSnip",
                        nvim_lua = "Lua",
                        latex_symbols = "Latex",
                    },
                }),
            },
            matching = {
                disallow_prefix_matching = false,
                disallow_fuzzy_matching = false,
                disallow_fullfuzzy_matching = false,
                disallow_partial_fuzzy_matching = false,
            },
            experimental = {
                ghost_text = true,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-J>"] = cmp.mapping.scroll_docs(-4),
                ["<C-K>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                    -- that way you will only jump inside the snippet region
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp", group_index = 1 },
                { name = "luasnip", group_index = 2 },
                { name = "buffer", gorup_index = 3 },
                { name = "nvim_lsp_signature_help" },
                { name = "path" },
                { name = "emoji" },
                { name = "nerdfont" },
            }),
        })

        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "git" },
            }, {
                { name = "buffer" },
            }),
        })

        cmp.setup.filetype("markdown", {
            sources = cmp.config.sources({
                { name = "spell" },
                { name = "buffer" },
            }),
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "nvim_lsp_document_symbol" },
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })

        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
