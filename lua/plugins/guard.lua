local M = {
    "nvimdev/guard.nvim",
    dependencies = {
        "nvimdev/guard-collection",
    },
    event = "LspAttach",
    config = function()
        local ft = require("guard.filetype")
        local variables = require("utils.variables")

        for filetype, opts in pairs(variables.Ft_Opts) do
            if opts.formatter then
                if opts.linter then
                    ft(filetype):fmt(opts.formatter.formatter):lint(opts.linter.linter)
                else
                    ft(filetype):fmt(opts.formatter.formatter)
                end
            end
        end

        -- FIX: Gives error for multiple file encoding. fix it.
        -- ft("*"):lint("codespell")

        require("guard").setup({
            fmt_on_save = true,
            lsp_as_default_formatter = false,
        })
        -- NB: this does not work with formatters

        vim.cmd("GuardEnable")
    end,
}

return M
