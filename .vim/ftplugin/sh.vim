" Shell 脚本配置：显示 Tab 和行尾多余空格，但不显示普通空格
setlocal noexpandtab         " 使用真实 Tab 字符（Shell 通常允许 Tab 或空格）
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4

" 显示不可见字符：只显示 Tab 和行尾空格
setlocal list
setlocal listchars=tab:>·,trail:·

" 降低 list 字符的可见性（浅灰色）
highlight SpecialKey ctermfg=8 guifg=#555555
highlight NonText ctermfg=8 guifg=#555555" Shell 脚本配置
setlocal noexpandtab         " 使用真正的 Tab 字符（Shell 标准）
setlocal shiftwidth=4        " 自动缩进 4 空格
setlocal softtabstop=4       " Tab 键插入 4 空格（但实际是 Tab）
setlocal tabstop=4           " 显示 Tab 为 4 空格宽度

" 显示不可见字符（空格、Tab）
setlocal list                " 启用显示特殊字符
setlocal listchars=tab:>·,space:·,trail:·,nbsp:␣
" 说明：
"   tab:>·   → Tab 显示为 "> "（一个大于号加一个点）
"   space:·  → 普通空格显示为 "·"
"   trail:·  → 行尾多余空格显示为 "·"
"   nbsp:␣   → 不间断空格显示为 "␣"
