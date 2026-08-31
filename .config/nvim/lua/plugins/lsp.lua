-- ============================================================================
-- 语言服务（LSP）类插件（lua/plugins/lsp.lua）
-- ============================================================================
-- LSP = Language Server Protocol，让 nvim 获得「跳转定义、代码补全、报错提示」等
-- 智能能力。本文件管理三件事：
--   1. mason：下载安装各种语言服务器（LSP server）的工具
--   2. nvim-lspconfig：配置这些语言服务器如何工作
--   3. trouble：把报错 / 符号以漂亮列表的形式展示
--
-- ── 想给新语言加 LSP 支持 ─────────────────────────────────
--   1. 在下面 mason-lspconfig 的 ensure_installed 列表里加服务器名
--      （可用 :Mason 命令查看所有可装的名字）
--   2. 在 nvim-lspconfig 的 config 里加一段 vim.lsp.config("名字", {...})
-- ============================================================================

return {
  -- ==========================================================================
  -- mason：语言服务器安装器（相当于 LSP 世界的「应用商店」）
  -- ==========================================================================
  {
    "williamboman/mason.nvim",
    cmd = "Mason",            -- 只有执行 :Mason 命令时才真正加载
    build = ":MasonUpdate",   -- 安装后自动更新服务器注册表
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- ==========================================================================
  -- mason-lspconfig：让 mason 和 lspconfig 联动（自动装好列表里的服务器）
  -- ==========================================================================
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- 启动时自动安装这些语言服务器
      -- 加语言：在这里加一个名字（如 "rust_analyzer"、"gopls"、"html"）
      -- 删语言：删掉对应名字即可
      ensure_installed = {
        "lua_ls",    -- Lua
        "pyright",   -- Python
        "clangd",    -- C / C++
        "asm_lsp",   -- GNU 汇编（GAS）
      },
    },
  },

  -- ==========================================================================
  -- nvim-lspconfig：LSP 客户端配置（告诉 nvim 每个语言服务器怎么跑）
  -- ==========================================================================
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",   -- 让 LSP 的补全能力接入补全菜单
    },
    event = "BufReadPre",       -- 打开文件时才加载（不用启动时加载）
    config = function()
      -- capabilities：声明「本客户端支持哪些 LSP 能力」，
      -- 其中补全能力由 cmp-nvim-lsp 提供，缺少它补全菜单会失灵
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 全局默认配置（所有语言服务器共用）
      vim.lsp.config("*", {
        capabilities = capabilities,
        root_markers = { ".git" },  -- 以 .git 目录作为「项目根目录」的判断依据
      })

      -- ===================== 各语言服务器单独配置 =====================

      -- Lua
      vim.lsp.config("lua_ls", {
        filetypes = { "lua" },
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },  -- 告诉 lua_ls：vim 是全局变量
            checkThirdParty = "Apply",
          },
        },
      })

      -- C / C++（clangd）
      -- STM32 交叉编译依靠 compile_commands.json 提供 include 路径；
      -- --query-driver 让 clangd 能识别 arm-none-eabi-gcc 的内建头文件路径。
      vim.lsp.config("clangd", {
        filetypes = { "c", "cpp" },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--query-driver=/usr/bin/arm-none-eabi-gcc",
        },
      })

      -- GNU 汇编（asm-lsp）
      -- 默认 gas（AT&T）语法 + x86-64 目标；文件类型覆盖 .s / .S / .asm。
      -- 如需 ARM（STM32 启动汇编），在项目根放 .asm-lsp.toml 指定：
      --   [instruction_set]
      --   target = "arm"
      --   syntax = "gas"
      vim.lsp.config("asm_lsp", {
        filetypes = { "asm" },
      })
    end,
  },

  -- ==========================================================================
  -- trouble：诊断 / 符号的漂亮列表面板（集中查看所有报错）
  -- ==========================================================================
  {
    "folke/trouble.nvim",
    opts = {},            -- 用默认配置
    event = "VeryLazy",
    keys = {
      -- 切换诊断列表（全工作区报错）
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "切换诊断" },
      -- 只看当前文件的报错
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "当前文件诊断" },
      -- 当前文件符号（函数 / 变量）
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "文档符号" },
      -- LSP 跳转记录
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP 跳转" },
      -- 位置列表 / 快速修复列表
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "位置列表" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "快速修复" },
    },
  },

  -- ==========================================================================
  -- fidget：右下角显示 LSP 的工作状态（如「正在索引…」）
  -- ==========================================================================
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = function()
      require("fidget").setup()
    end,
  },
}
