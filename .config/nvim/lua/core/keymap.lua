local keymap = vim.keymap
-- 消除按键延迟
vim.opt.timeoutlen = 500

-- 设置 leader 键为空格
vim.g.mapleader = " "

-- jk 返回普通模式
keymap.set({"i","v"}, "jk", "<Esc>")
-- ------------插入模式-------------- --

-- ------------视觉模式-------------- --
-- 选定行移动
keymap.set("v","J",":m '>+1<CR>gv=gv") 
keymap.set("v","K",":m '<-2<CR>gv=gv") 

-- ------------普通模式-------------- --
-- 反向缩进：Shift+Tab 向左缩进
keymap.set("n", "<S-Tab>", "<<")

-- 窗口

-- 插入水平分割 
keymap.set("n","<leader>sp","<C-w>s")
-- 插入垂直分割
keymap.set("n","<leader>vs","<C-w>v")

-- 窗口焦点切换
keymap.set("n","<Leader>wh","<C-w>h")
keymap.set("n","<Leader>wj","<C-w>j")
keymap.set("n","<Leader>wk","<C-w>k")
keymap.set("n","<Leader>wl","<C-w>l")
-- 窗口位置切换)
keymap.set("n","<Leader>wH","<C-w>H")
keymap.set("n","<Leader>wJ","<C-w>J")
keymap.set("n","<Leader>wK","<C-w>K")
keymap.set("n","<Leader>wL","<C-w>L")
keymap.set("n","<Leader>wx","<C-w>x")
-- 窗口均分
keymap.set("n","<Leader>w=", "<C-w>=")
-- 关闭其他窗口
keymap.set("n","<Leader>wo","<C-w>o")

-- 取消高亮
keymap.set("n","<leader>nh",":nohl<CR>")


-- ------------------插件--------------------- --
-- nvim-tree
keymap.set("n","<leader>e",":NvimTreeToggle<CR>")
