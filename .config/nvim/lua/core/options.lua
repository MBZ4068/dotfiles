-- ============================================================================
-- 编辑器基础选项（lua/core/options.lua）
-- ============================================================================
-- 这里集中管理 nvim 的「编辑器本身」行为：行号、缩进、搜索、分屏等。
-- 每一项都是 vim.opt.xxx，改起来很直观：直接改等号右边的值即可。
--
-- 注意：配色主题不在这里设置（它由 lua/plugins/ui.lua 里的 tokyonight 负责）。
-- ============================================================================

-- 行号：左侧同时显示「绝对行号 + 相对行号」
--   绝对行号 = 每一行的真实编号（第 1 行、第 2 行……）
--   相对行号 = 其他行相对当前光标行的距离，方便用 3j / 5k 快速跳转
vim.opt.number = true
vim.opt.relativenumber = true

-- 启用文件类型检测 + 文件类型插件 + 文件类型缩进规则（务必保持开启）
vim.cmd("filetype plugin indent on")

-- 光标上下移动时，始终保留 5 行「上下文」，避免光标顶到屏幕边缘
vim.opt.scrolloff = 5

-- Tab 与缩进：宽度为 4，使用真正的制表符（不转换成空格）
--   注意：如果你主要写 Python（严格要求空格缩进），把 expandtab 改成 true
vim.opt.tabstop = 4       -- 一个 Tab 字符在屏幕上显示为几个空格宽
vim.opt.shiftwidth = 4    -- 按 >> / << 自动缩进时的宽度
vim.opt.expandtab = false -- false = 保留 Tab 字符；true = 转成空格

-- 分屏时新窗口的默认位置：右边（水平分割）和下边（垂直分割）
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 高亮当前光标所在的行和列，方便快速定位
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- 长行自动折行显示，且只在单词边界断开（不会把一个单词从中间截断）
vim.opt.wrap = true
vim.opt.linebreak = true

-- 输入右括号时，短暂高亮与之配对的左括号
vim.opt.showmatch = true

-- 搜索行为
vim.opt.ignorecase = true  -- 搜索时默认忽略大小写
vim.opt.smartcase = true   -- 但只要输入了大写字母，就自动区分大小写
vim.opt.hlsearch = true    -- 搜索结果保持高亮
vim.opt.incsearch = true   -- 边输入边实时搜索（即时预览）

-- 使用系统剪贴板：nvim 里复制/粘贴与系统其他程序互通
vim.opt.clipboard = "unnamedplus"

-- 启用鼠标：可以点击定位、滚轮滚动、拖拽窗口分割线
vim.opt.mouse = "a"
