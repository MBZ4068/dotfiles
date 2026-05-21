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
keymap.set("n","<leader>w-","<C-w>s",{desc = "水平分割"})
-- 插入垂直分割
keymap.set("n","<leader>w\\","<C-w>v",{desc = "垂直分割"})

-- 窗口焦点切换
keymap.set("n","<Leader>wh","<C-w>h",{desc = "左移焦点"})
keymap.set("n","<Leader>wj","<C-w>j",{desc = "下移焦点"})
keymap.set("n","<Leader>wk","<C-w>k",{desc = "上移焦点"})
keymap.set("n","<Leader>wl","<C-w>l",{desc = "右移焦点"})
-- 窗口位置切换
keymap.set("n","<Leader>wH","<C-w>H",{desc = "移到左边"})
keymap.set("n","<Leader>wJ","<C-w>J",{desc = "移到下边"})
keymap.set("n","<Leader>wK","<C-w>K",{desc = "移到上边"})
keymap.set("n","<Leader>wL","<C-w>L",{desc = "移到右边"})
keymap.set("n","<Leader>wx","<C-w>x",{desc = "交换窗口"})
-- 窗口均分
keymap.set("n","<Leader>w=", "<C-w>=",{desc = "均分窗口"})
-- 关闭其他窗口
keymap.set("n","<Leader>wo","<C-w>o",{desc = "关闭其他"})

-- 取消高亮
keymap.set("n","<leader>nh",":nohl<CR>",{desc = "取消高亮"})

-- 反向缩进
keymap.set("n","<S-Tab>","<<",{desc = "反向缩进"})


-- 切换buftab
keymap.set('n','<Leader>b<Tab>',":bnext<CR>",{silent = true , desc = '下一个 Buffer'})
keymap.set('n','<Leader>bq',":bd<CR>",{silent = true, desc = '删除当前 Buffer'})

-- ============================================
-- LSP / 代码导航（fzf-lua 浮动窗口）
-- ============================================
-- K：悬停文档（noice 自动加边框）
keymap.set("n", "K", function()
  vim.lsp.buf.hover()
end, { desc = "LSP 悬停" })

-- gd：跳转定义
keymap.set("n", "gd", function()
  require("fzf-lua").lsp_definitions()
end, { desc = "跳转定义" })

-- gr：引用列表
keymap.set("n", "gr", function()
  require("fzf-lua").lsp_references()
end, { desc = "引用列表" })

-- gi：接口实现
keymap.set("n", "gi", function()
  require("fzf-lua").lsp_implementations()
end, { desc = "接口实现" })

-- <leader>ds：当前文件符号（变量/函数导航）
keymap.set("n", "<leader>ds", function()
  require("fzf-lua").lsp_document_symbols()
end, { desc = "文档符号" })

-- <leader>ws：工作区符号搜索
keymap.set("n", "<leader>ws", function()
  require("fzf-lua").lsp_live_workspace_symbols()
end, { desc = "工作区符号" })

-- <leader>dd：当前文件诊断
keymap.set("n", "<leader>dd", function()
  require("fzf-lua").diagnostics_document()
end, { desc = "文档诊断" })

-- <leader>dD：全工作区诊断
keymap.set("n", "<leader>dD", function()
  require("fzf-lua").diagnostics_workspace()
end, { desc = "工作区诊断" })

-- <leader>ca：代码操作
keymap.set({"n", "v"}, "<leader>ca", function()
  require("fzf-lua").lsp_code_actions()
end, { desc = "代码操作" })

-- <leader>cr：重命名
keymap.set("n", "<leader>cr", function()
  vim.lsp.buf.rename()
end, { desc = "重命名" })

-- ============================================
-- DAP 调试（<leader>g 组）
-- ============================================
keymap.set("n", "<leader>gb", function() require("dap").toggle_breakpoint() end, { desc = "切换断点" })
keymap.set("n", "<leader>gB", function()
  require("dap").set_breakpoint(vim.fn.input("断点条件: "))
end, { desc = "条件断点" })
keymap.set("n", "<leader>gc", function() require("dap").continue() end, { desc = "继续/启动" })
keymap.set("n", "<leader>gi", function() require("dap").step_into() end, { desc = "单步进入" })
keymap.set("n", "<leader>go", function() require("dap").step_out() end, { desc = "单步跳出" })
keymap.set("n", "<leader>gl", function() require("dap").step_over() end, { desc = "单步越过" })
keymap.set("n", "<leader>gr", function() require("dap").restart() end, { desc = "重启" })
keymap.set("n", "<leader>gq", function() require("dap").close() end, { desc = "停止调试" })
keymap.set("n", "<leader>gu", function()
  require("dapui").toggle()
end, { desc = "切换调试UI" })
keymap.set({ "n", "v" }, "<leader>gh", function()
  require("dapui").eval()
end, { desc = "查看变量" })

