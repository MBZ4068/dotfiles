
" 显示行号
set number

" 相对行号
set relativenumber

" 语法高亮
syntax on

" 移动时保留上下文（光标上下至少保留5行）
set scrolloff=5

" Tab 宽度为4个空格，但不替换成空格（使用真正的制表符）
set tabstop=4
set shiftwidth=4
set noexpandtab      " 按 Tab 插入制表符，而非空格

" 防止单词被截断（在单词边界处换行）
set linebreak
set wrap

" 默认新窗口右和下
set splitright 
set splitbelow

" 光标所在行列高亮
set cursorline
set cursorcolumn

" 括号匹配（短暂跳转并显示匹配括号）
set showmatch


" 搜索不区分大小写（混合大写字母时自动区分）
set ignorecase
set smartcase

" 搜索高亮
set hlsearch
set incsearch

" 系统剪切板
set clipboard=unnamedplus

let s:clor_SI="\<Esc>]12;#56EBFC\<Esc>\\"

let s:clor_SR="\<Esc>]12;#FC5656\<Esc>\\"
let s:clor_EI="\<Esc>]12;#E7FA7F\<Esc>\\"
" 设置插入模式为竖线光标
let &t_SI = s:clor_SI . "\<Esc>[6 q"
" 设置替换模式为下划线光标
let &t_SR = s:clor_SR . "\<Esc>[4 q"
" 设置普通模式为方块光标
let &t_EI = s:clor_EI . "\<Esc>[2 q"

" 开启鼠标支持
set mouse=a



