local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = LAZY_PLUGIN_SPEC,
    defaults = {
        lazy = true,
    },
    install = {
        missing = true,
        colorscheme = { "default" },
    },
    ui = {
        border = "none", -- none, single, double, rounded, solid, shadow
    },
    checker = {
        enabled = true,
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
})
