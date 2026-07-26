-- 在 setup 之前或之后加上这行自动命令即可
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "NvimTree_*",          -- 匹配 nvim-tree 的 buffer 名称
  callback = function()
    -- 当前窗口是树，且只有这一个窗口 → 退出
    if vim.fn.winnr("$") == 1 then
      vim.cmd("confirm quit")
    end
  end,
})

require("nvim-tree").setup({
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = { enable = false },
    },
  },
})
