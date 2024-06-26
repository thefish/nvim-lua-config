-- plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

local lazyOpts = {
    root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
    defaults = {
        -- lazy = false, -- should plugins be lazy-loaded?
        version = nil,
        -- default `cond` you can use to globally disable a lot of plugins
        -- when running inside vscode for example
        cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
        -- version = "*", -- enable this to try installing the latest stable versions of plugins
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false
    }
}

require("lazy").setup({
    {import="thefish.plugins"},
}, lazyOpts)
