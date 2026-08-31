-- ============================================================================
-- 代码补全类插件（lua/plugins/cmp.lua）
-- ============================================================================
-- 本文件管理「自动补全」：nvim-cmp 是补全引擎，LuaSnip 是代码片段。
-- 补全来源（source）依次是：LSP 结果 → 代码片段 → 文件路径 → 当前文件单词。
--
-- ── 如何维护 ────────────────────────────────────────────────
-- · 想加补全来源：在 cmp.setup 的 sources 里加 { name = "xxx" }
-- · 想改补全菜单图标样式：改 formatting 里的 mode 参数
-- ============================================================================

return {
  -- ==========================================================================
  -- 补全引擎：nvim-cmp（核心）
  -- 它的依赖（cmp-nvim-lsp / LuaSnip / lspkind 等）会随它一起加载
  -- ==========================================================================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",        -- 进入插入模式时才加载，加快启动
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",           -- 让补全菜单显示 LSP 的结果
      "L3MON4D3/LuaSnip",               -- 代码片段引擎
      "saadparwaiz1/cmp_luasnip",       -- 把代码片段接入补全
      "rafamadriz/friendly-snippets",   -- 预置的常用代码片段库
      "onsails/lspkind.nvim",           -- 补全项左侧的类型图标
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- 加载 friendly-snippets 里的 VS Code 风格片段（如 for、if 等模板）
      require("luasnip.loaders.from_vscode").lazy_load()

      -- 辅助函数：判断光标前一个字符是不是空白（用于 Tab 键回退逻辑）
      local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
      end

      cmp.setup({
        -- 代码片段展开方式：交给 LuaSnip 处理
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        -- 补全菜单的按键操作
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),   -- 向上滚动补全文档
          ["<C-f>"] = cmp.mapping.scroll_docs(4),    -- 向下滚动补全文档
          ["<C-e>"] = cmp.mapping.abort(),           -- 关闭补全菜单
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 回车确认选中项

          -- Tab：选择下一个补全项 / 展开代码片段 / 跳到下一个占位符
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Shift+Tab：选择上一个补全项 / 跳回上一个占位符
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        -- 补全来源（按优先级从高到低）
        sources = cmp.config.sources({
          { name = "nvim_lsp" },   -- LSP 结果（智能补全，优先级最高）
          { name = "luasnip" },    -- 代码片段
          { name = "path" },       -- 文件路径补全
        }, {
          { name = "buffer" },     -- 当前文件里出现过的单词（兜底）
        }),

        -- 补全菜单左侧的类型图标（用 lspkind + devicons 字体）
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol_text",  -- 显示图标 + 文字
            maxwidth = 50,         -- 菜单项最大宽度
            ellipsis_char = "...",
          }),
        },
      })
    end,
  },
}
