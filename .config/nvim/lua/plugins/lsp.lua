require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  }
})

require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
  ensure_installed = {
    "lua_ls","pyright"
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*',{
	capabilities = capabilities,
	root_markers = {'.git'},
})

vim.lsp.config('lua_ls',{
	filetypes = { 'lua' },
	settings={
		Lua={
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = {'vim'}},
			checkThirdParty = 'Apply'
			}
		}
	}
)


