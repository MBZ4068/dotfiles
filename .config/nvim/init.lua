-- ~/.config/nvim/init.lua 最开头部分
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 使用稳定分支
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("core.options")
require("core.keymap")
require("plugins.plugins-setup")

-- 插件
require("plugins.delimiters")
---- 
require("plugins.lsp")
require("plugins.cmp")



