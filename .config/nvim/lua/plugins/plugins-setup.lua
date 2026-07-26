-- 1. 自动安装 lazy.nvim（类似原来的 packer 引导）
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 推荐使用稳定分支
    lazypath,
 })
end
vim.opt.rtp:prepend(lazypath)

-- 2. 插件配置列表
require("lazy").setup({

  -- 主题（建议立即加载，否则启动时无主题）
  { "folke/tokyonight.nvim",
    lazy = false,        -- 启动时立即加载
    priority = 1000,     -- 高优先级，确保主题先加载
    config = function()
      vim.cmd.colorscheme("tokyonight-moon")
    end
  },
	{
	  "nvim-treesitter/nvim-treesitter",
	  lazy = false,
	  build = ':TSUpdate',
	  config = function()
		require('nvim-treesitter').install { 'rust', 'lua', 'python','vim'}
	end
	},

  { "HiPhish/rainbow-delimiters.nvim",
  	lazy = false
  },
  -- ============================================
  -- TUI 美化：核心依赖
  -- ============================================
  {
    "MunifTanjim/nui.nvim",
    lazy = true, -- noice 会按需加载
  },

  {
    "rcarriga/nvim-notify",
    lazy = true,
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        render = "default",
        stages = "fade_in_slide_out",
      })
      vim.notify = require("notify")
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,      -- 搜索框在底部
          command_palette = true,    -- 命令面板
          long_message_to_split = true, -- 长消息自动切到分屏
          inc_rename = true,
          lsp_doc_border = true,     -- LSP 文档加边框
        },
      })
    end,
  },

  -- ============================================
  -- which-key：按键提示
  -- ============================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern",
        delay = 200,
        triggers = {
          { "<auto>", mode = "nixso" },
        },
      })
      -- 按键分组（子项由 keymap / lazy keys 的 desc 自动发现）
      wk.add({
        { "<leader>w", group = "窗口" },
        { "<leader>d", group = "诊断" },
        { "<leader>c", group = "代码" },
        { "<leader>x", group = "诊断面板" },

        { "<leader>b", group = "Buffer" },
        { "<leader>n", group = "搜索" },
        { "<leader>f", group = "模糊搜索" },
        { "<leader>g", group = "调试" },
        { "<leader>e", desc = "切换文件树" },

        { "K",  desc = "LSP 悬停" },
        { "gd", desc = "跳转定义" },
        { "gr", desc = "引用列表" },
        { "gi", desc = "接口实现" },
      })
    end,
  },

  -- ============================================
  -- bufferline：标签栏
  -- ============================================
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "ordinal",
          indicator = {
            style = "none",
          },
          separator_style = "slant",
          always_show_bufferline = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          color_icons = true,
        },
      })
      vim.opt.showtabline = 2
    end,
  },

  -- ============================================
  -- indent-blankline：缩进线
  -- ============================================
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    config = function()
      require("ibl").setup({
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
          highlight = { "Function", "Label" },
        },
        indent = {
          char = "▏",
        },
      })
    end,
  },

  -- ============================================
  -- twilight：非活动窗口变暗
  -- ============================================
  {
    "folke/twilight.nvim",
    event = "VeryLazy",
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.25,
          color = { "Normal" },
        },
        context = 10,
        treesitter = true,
      })
    end,
  },

  -- ============================================
  -- todo-comments：注释高亮
  -- ============================================
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏣ ", color = "error", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        highlight = {
          keyword = "bg",
          after = "",
          pattern = [[.*<(KEYWORDS)\s*:]],
        },
        search = {
          command = "rg",
          args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
        },
      })
    end,
  },

  -- ============================================
  -- 原有插件（保持不变）
  -- ============================================

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" }, -- 原 requires
    event = "VeryLazy",  -- 空闲时加载，提速启动
    config = function()
      require("lualine").setup()
    end
  },

  -- 文件树 nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy=false,
    config = function()
		vim.g.loaded_netrw =1
		vim.g.loaded_netrwPlugin=1

      require("nvim-tree").setup()
    end
  },

  -- LSP 生态（mason + lspconfig）
  { "williamboman/mason.nvim",
    cmd = "Mason",        -- 执行 :Mason 时才加载
    build = ":MasonUpdate", -- 可选：更新注册表
    config = function()
      require("mason").setup()
    end
  },

  { "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup()
    end
  },
  { "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    event = "BufReadPre", -- 打开文件时加载 LSP 配置
    config = function()
      -- 这里可以放你的 LSP 配置，例如：
      -- local lspconfig = require("lspconfig")
      -- lspconfig.lua_ls.setup{}
    end
  },

  -- 自动补全 (nvim-cmp 及相关)
  { "hrsh7th/nvim-cmp", event = "InsertEnter", config = function() require("cmp").setup() end },
  { "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/nvim-cmp" } },
  { "L3MON4D3/LuaSnip", event = "InsertEnter", config = function() require("luasnip").setup() end },
  { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip", "hrsh7th/nvim-cmp" } },
  { "rafamadriz/friendly-snippets", dependencies = { "L3MON4D3/LuaSnip" } },

  -- UI 增强
  { "onsails/lspkind.nvim", dependencies = { "hrsh7th/nvim-cmp" }, config = function() require("lspkind").init() end },
  { "j-hui/fidget.nvim", event = "VeryLazy", config = function() require("fidget").setup() end },

  -- 报错显示（原配置中已带有 opts = {}）
	{
	  "folke/trouble.nvim",
	  opts ={}, -- for default options, refer to the configuration section for custom setup.
	  event="VeryLazy",
	  keys = {
		{
		  "<leader>xx",
		  "<cmd>Trouble diagnostics toggle<cr>",
		  desc = "切换诊断",
		},
		{
		  "<leader>xX",
		  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		  desc = "当前文件诊断",
		},
		{
		  "<leader>cs",
		  "<cmd>Trouble symbols toggle focus=false<cr>",
		  desc = "文档符号",
		},
		{
		  "<leader>cl",
		  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		  desc = "LSP 跳转",
		},
		{
		  "<leader>xL",
		  "<cmd>Trouble loclist toggle<cr>",
		  desc = "位置列表",
		},
		{
		  "<leader>xQ",
		  "<cmd>Trouble qflist toggle<cr>",
		  desc = "快速修复",
		},},},
	{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
	},
	{
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@diagnostic disable: missing-fields
 opts = {}
  ---@diagnostic enable: missing-fields
},
-- 光标拖影
{
  "sphamba/smear-cursor.nvim",
  opts = {},
},
{
  "yianwillis/vimcdoc",
  lazy = false, -- 确保在启动时加载
  config = function()
    -- 可选: 设置帮助语言为中文
    vim.cmd('set helplang=cn')
  end
},
-- markdown 渲染插件
   {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {},
      ft = "markdown",
 },
 
   -- ============================================
  -- DAP 调试生态
  -- ============================================
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function()
      local dap = require("dap")
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
          args = { "--port", "${port}" },
        },
      }
      dap.configurations.rust = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/",  "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.rust
      dap.configurations.cpp = dap.configurations.rust
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
    config = function()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = { "codelldb", "debugpy" },
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },

  -- image.nvim：终端内显示图片（Kitty 协议）
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    config = function()
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
          },
        },
      })
    end,
  },
},
	-- 在插件管理器的配置中
{
  -- 全局 lazy 配置（可选）
  install = {
    colorscheme = { "tokyonight" }, -- 安装插件时使用的主题
  },
  checker = {
    enabled = true,       -- 定期检查插件更新（默认每周）
	interval = 24 * 60 * 60 * 1000,
  },
})

-- 3. 可选：设置全局快捷键（原配置没有，但可以根据需要添加）
 vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
