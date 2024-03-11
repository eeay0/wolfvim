return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    --event = "UiEnter",
    lazy = false,
    dependencies = {
        "williamboman/mason.nvim",
    },
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local tools = {}
        local Ft_Opts = require("utils.variables").Ft_Opts

        for _, lang in pairs(Ft_Opts) do
            if lang.lsp then table.insert(tools, lang.lsp.package_name) end
            if lang.linter then table.insert(tools, lang.linter.package_name) end
            if lang.formatter then table.insert(tools, lang.formatter.package_name) end
            if lang.dap then table.insert(tools, lang.dap.package_name) end
        end

        require("mason-tool-installer").setup({
            ensure_installed = tools,
            auto_update = true,
            run_on_start = true,
            start_delay = 100,
        })
    end,
}
