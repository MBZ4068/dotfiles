local fzf_lua = require('fzf-lua')
-- 全局映射
vim.keymap.set('n', '<leader>ff', fzf_lua.files, { desc = '文件搜索' })
vim.keymap.set('n', '<leader>fg', fzf_lua.live_grep, { desc = '实时Grep' })
vim.keymap.set('n', '<leader>fb', function()
  require('fzf-lua').buffers({
    actions = {
      ['default'] = require('fzf-lua').actions.buf_edit,
    },
  })
end, { desc = '缓冲区' })
vim.keymap.set('n', '<leader>fo', fzf_lua.oldfiles, { desc = '历史文件' })
vim.keymap.set('n', '<leader>fG', fzf_lua.git_files, { desc = 'Git文件' })
vim.keymap.set('n', '<leader>fh', fzf_lua.help_tags, { desc = '帮助' })
