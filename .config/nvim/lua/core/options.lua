

--默认主题
vim.cmd[[colorscheme tokyonight-moon]]



-- 行号
vim.opt.number = true          -- 显示绝对行号
vim.opt.relativenumber = true -- 相对行号

vim.cmd('filetype plugin indent on')

-- 移动时保留上下文
vim.opt.scrolloff = 5

-- Tab 与缩进：宽度为4，使用真正制表符（不转空格）
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- 默认新窗口右和下
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- 折行时不截断单词
vim.opt.linebreak = true
vim.opt.wrap = true

-- 括号匹配：短暂跳转显示配对
vim.opt.showmatch = true

-- 启用备份文件（生成 filename~）
--vim.opt.backup = true

-- 搜索：智能忽略大小写、高亮、即时搜索
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- 使用系统剪切板
vim.opt.clipboard = 'unnamedplus'

-- 鼠标支持
vim.opt.mouse = 'a'
-- 报错显示
vim.diagnostic.config({
  virtual_lines ={ only_current_line =  true},
})
vim.cmd("autocmd BufNewFile *.cmdn 0r ~/.config/nvim/note_template.cmdn")
