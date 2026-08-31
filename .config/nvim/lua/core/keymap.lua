-- ============================================================================
-- 全局快捷键（lua/core/keymap.lua）
-- ============================================================================
-- 这里集中管理所有「手动设置」的快捷键，按功能分块，方便查找和修改。
--
-- 改键说明（照葫芦画瓢即可）：
--   keymap.set("模式", "按键", "动作或函数", { desc = "这个键是干嘛的" })
--   · 模式：n = 普通模式，v = 视觉模式，i = 插入模式
--   · <leader> 默认是空格键（见下面 mapleader 设置）
--
-- 提示：LSP / DAP 相关的键位也集中在这里（用 require("fzf-lua") 懒加载），
--       而「插件自己定义的触发键」（如文件树 <leader>e）放在各插件文件里。
-- ============================================================================

local keymap = vim.keymap

-- 消除按键序列的等待延迟（毫秒），太小会让组合键难按
vim.opt.timeoutlen = 500

-- 设置 <leader>（前缀键）为空格键
vim.g.mapleader = " "

-- ============================================================================
-- 基础编辑
-- ============================================================================
-- jk 连按：从插入模式 / 视觉模式快速返回普通模式（比按 Esc 更快）
keymap.set({ "i", "v" }, "jk", "<Esc>", { desc = "返回普通模式" })

-- 视觉模式下移动选中的行（J 下移一行，K 上移一行）
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "选中行下移" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "选中行上移" })

-- Shift+Tab：向左减少缩进
keymap.set("n", "<S-Tab>", "<<", { desc = "反向缩进" })

-- 取消搜索高亮
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "取消高亮" })

-- ============================================================================
-- Buffer（打开的文件）切换
-- ============================================================================
keymap.set("n", "<leader>b<Tab>", ":bnext<CR>", { silent = true, desc = "下一个 Buffer" })
keymap.set("n", "<leader>bq", ":bd<CR>", { silent = true, desc = "删除当前 Buffer" })

-- ============================================================================
-- 窗口管理（<leader>w 开头的都是窗口操作）
-- ============================================================================
keymap.set("n", "<leader>w-", "<C-w>s", { desc = "水平分割" })
keymap.set("n", "<leader>w\\", "<C-w>v", { desc = "垂直分割" })

-- 焦点切换（光标在哪个窗口）
keymap.set("n", "<leader>wh", "<C-w>h", { desc = "焦点移到左边窗口" })
keymap.set("n", "<leader>wj", "<C-w>j", { desc = "焦点移到下边窗口" })
keymap.set("n", "<leader>wk", "<C-w>k", { desc = "焦点移到上边窗口" })
keymap.set("n", "<leader>wl", "<C-w>l", { desc = "焦点移到右边窗口" })

-- 窗口位置交换（把当前窗口移动到最左/最下/最上/最右）
keymap.set("n", "<leader>wH", "<C-w>H", { desc = "窗口移到最左" })
keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "窗口移到最下" })
keymap.set("n", "<leader>wK", "<C-w>K", { desc = "窗口移到最上" })
keymap.set("n", "<leader>wL", "<C-w>L", { desc = "窗口移到最右" })
keymap.set("n", "<leader>wx", "<C-w>x", { desc = "交换相邻窗口" })

-- 窗口大小
keymap.set("n", "<leader>w=", "<C-w>=", { desc = "窗口均分大小" })
keymap.set("n", "<leader>wo", "<C-w>o", { desc = "只保留当前窗口" })

-- ============================================================================
-- LSP / 代码导航
-- （这些键位用 fzf-lua 提供浮动窗口；按下去才会加载 fzf-lua，不拖慢启动）
-- ============================================================================
-- K：悬停显示符号文档
keymap.set("n", "K", function()
  vim.lsp.buf.hover()
end, { desc = "LSP 悬停文档" })

-- gd：跳转到定义
keymap.set("n", "gd", function()
  require("fzf-lua").lsp_definitions()
end, { desc = "跳转定义" })

-- gr：查看所有引用
keymap.set("n", "gr", function()
  require("fzf-lua").lsp_references()
end, { desc = "引用列表" })

-- gi：跳转到接口实现
keymap.set("n", "gi", function()
  require("fzf-lua").lsp_implementations()
end, { desc = "接口实现" })

-- <leader>ds：当前文件的符号（函数 / 变量）导航
keymap.set("n", "<leader>ds", function()
  require("fzf-lua").lsp_document_symbols()
end, { desc = "文档符号" })

-- <leader>ws：整个工作区的符号搜索
keymap.set("n", "<leader>ws", function()
  require("fzf-lua").lsp_live_workspace_symbols()
end, { desc = "工作区符号" })

-- <leader>dd：当前文件的诊断（错误 / 警告）列表
keymap.set("n", "<leader>dd", function()
  require("fzf-lua").diagnostics_document()
end, { desc = "当前文件诊断" })

-- <leader>dD：整个工作区的诊断列表
keymap.set("n", "<leader>dD", function()
  require("fzf-lua").diagnostics_workspace()
end, { desc = "工作区诊断" })

-- <leader>ca：代码操作（快速修复 / 自动导入等）
keymap.set({ "n", "v" }, "<leader>ca", function()
  require("fzf-lua").lsp_code_actions()
end, { desc = "代码操作" })

-- <leader>cr：重命名符号
keymap.set("n", "<leader>cr", function()
  vim.lsp.buf.rename()
end, { desc = "重命名" })

-- <leader>df：浮动窗口显示当前行的诊断详情
keymap.set("n", "<leader>df", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "诊断浮动窗口" })

-- ============================================================================
-- DAP 调试（<leader>g 开头）
-- ============================================================================
keymap.set("n", "<leader>gb", function() require("dap").toggle_breakpoint() end, { desc = "切换断点" })
keymap.set("n", "<leader>gB", function()
  require("dap").set_breakpoint(vim.fn.input("断点条件: "))
end, { desc = "条件断点" })
keymap.set("n", "<leader>gc", function() require("dap").continue() end, { desc = "继续 / 启动调试" })
keymap.set("n", "<leader>gi", function() require("dap").step_into() end, { desc = "单步进入" })
keymap.set("n", "<leader>go", function() require("dap").step_out() end, { desc = "单步跳出" })
keymap.set("n", "<leader>gl", function() require("dap").step_over() end, { desc = "单步越过" })
keymap.set("n", "<leader>gr", function() require("dap").restart() end, { desc = "重启调试" })
keymap.set("n", "<leader>gq", function() require("dap").close() end, { desc = "停止调试" })
keymap.set("n", "<leader>gu", function() require("dapui").toggle() end, { desc = "切换调试面板" })
keymap.set({ "n", "v" }, "<leader>gh", function() require("dapui").eval() end, { desc = "查看变量值" })

-- ============================================================================
-- 运行当前文件（<leader>r）
-- ============================================================================
keymap.set("n", "<leader>r", function()
  -- 优先用 venv-selector 当前选中的解释器；没选过则退回系统 python3
  local ok, vs = pcall(require, "venv-selector")
  local py = (ok and vs and vs.python()) or "python3"
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("当前没有可运行的文件", vim.log.levels.WARN, { title = "运行" })
    return
  end
  local cmd = py .. " " .. vim.fn.shellescape(file)
  -- 在底部 toggleterm 终端里执行（终端打开时会自动激活当前 venv）
  require("toggleterm").exec(cmd, 1, 15, nil, "horizontal")
end, { desc = "运行当前 Python 文件" })

-- ============================================================================
-- 同步当前 venv 到 Pyright（<leader>pl）
-- 兜底：当 venv-selector 因“选中同一个 venv”短路、没自动更新 Pyright 时手动触发。
-- ============================================================================
keymap.set("n", "<leader>pl", function()
  local ok, vs = pcall(require, "venv-selector")
  if not ok or not vs then
    vim.notify("venv-selector 未加载（先打开 .py 文件）", vim.log.levels.WARN, { title = "Venv" })
    return
  end
  if not vs.python() then
    vim.notify("尚未选择 venv，请先 <leader>pv 选择", vim.log.levels.WARN, { title = "Venv" })
    return
  end
  vs.restart_lsp_servers()
  vim.notify("已把当前 venv 同步到 Pyright", vim.log.levels.INFO, { title = "Venv" })
end, { desc = "同步当前 venv 到 Pyright" })
