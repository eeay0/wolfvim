return {
    Ft_Opts = {
        lua = {
            lsp = { lsp = "lua_ls", package_name = "lua-language-server", conf = {} },
            linter = { linter = "luacheck", package_name = "luacheck" },
            formatter = { formatter = "stylua", package_name = "stylua" },
            dap = {},
        },
        python = {
            lsp = { lsp = "pyright", package_name = "pyright", conf = {} },
            linter = { linter = "flake8", package_name = "flake8" },
            formatter = { formatter = "autopep8", package_name = "autopep8" },
            dap = { dap = "debugpy", package_name = "debugpy" },
        },
        sh = {
            lsp = { lsp = "bashls", package_name = "bash-language-server", conf = {} },
            linter = { linter = "shellcheck", package_name = "shellcheck" },
            formatter = { formatter = "shfmt", package_name = "shfmt" },
        },
        c = {
            lsp = { lsp = "clangd", package_name = "clangd", conf = {} },
            linter = { linter = "clang-tidy", package_name = nil },
            formatter = { formatter = "clang-format", package_name = "clang-format" },
            -- formatter: GDB
        },
        json = {
            lsp = { lsp = "jsonls", package_name = "json-lsp", conf = {} },
        },
    },
}
