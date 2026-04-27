" Makefile 配置：必须显示行首 Tab（所有 Tab 都会显示），并显示行尾空格
setlocal noexpandtab         " 必须使用 Tab 字符
setlocal shiftwidth=8
setlocal softtabstop=8
setlocal tabstop=8

" 显示不可见字符：Tab 和行尾空格
setlocal list
setlocal listchars=tab:>·,trail:·

" 降低可见性（浅灰色，与 Shell 一致）
highlight SpecialKey ctermfg=8 guifg=#555555
highlight NonText ctermfg=8 guifg=#555555
