
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

-- 2. 插件配置列表（原 packer 的 use 部分）
require("lazy").setup({
  -- 主题（建议立即加载，否则启动时无主题）
  { "folke/tokyonight.nvim",
    lazy = false,        -- 启动时立即加载
    priority = 1000,     -- 高优先级，确保主题先加载
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end
  },
  -- 状态栏 lualine
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
    cmd = "NvimTreeToggle", -- 按需加载：执行命令时才加载
    config = function()
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
	  opts ={
		  modes={
		  	diagnostics={
				auto_open = true,  -- 出现诊断时自动打开
    			auto_close = true, -- 无诊断时自动关闭
		  		},
			},
  	  }, -- for default options, refer to the configuration section for custom setup.
	  event="VeryLazy",
	  keys = {
		{
		  "<leader>xx",
		  "<cmd>Trouble diagnostics toggle<cr>",
		  desc = "Diagnostics (Trouble)",
		},
		{
		  "<leader>xX",
		  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		  desc = "Buffer Diagnostics (Trouble)",
		},
		{
		  "<leader>cs",
		  "<cmd>Trouble symbols toggle focus=false<cr>",
		  desc = "Symbols (Trouble)",
		},
		{
		  "<leader>cl",
		  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		  desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
		  "<leader>xL",
		  "<cmd>Trouble loclist toggle<cr>",
		  desc = "Location List (Trouble)",
		},
		{
		  "<leader>xQ",
		  "<cmd>Trouble qflist toggle<cr>",
		  desc = "Quickfix List (Trouble)",
		},},},
	{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
	}

 -- 注意：原 packer.nvim 本身不再需要，lazy.nvim 已替代
}, {
  -- 全局 lazy 配置（可选）
  defaults = {
    lazy = true,          -- 未显式指定 lazy 的插件默认懒加载
  },
  install = {
    colorscheme = { "tokyonight" }, -- 安装插件时使用的主题
  },
  checker = {
    enabled = true,       -- 定期检查插件更新（默认每周）
	interval = 24 * 60 * 60 * 1000,
  },
})

-- 3. 可选：设置全局快捷键（原配置没有，但可以根据需要添加）
-- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
