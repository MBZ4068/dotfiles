" ~/.vimrc

set nocompatible          
filetype plugin indent on 
syntax on                
" ========== 基础设置=============

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



"============ 快捷键设置 ============
" 消除按键延迟
set timeoutlen=500

" 设置 leader 键为空格
let mapleader = " "

" jk 返回普通模式（插入 + 可视）
inoremap jk <Esc>

" ------------插入模式-------------- --

" ------------视觉模式-------------- --
" 选定行移动
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ------------普通模式-------------- --
" 反向缩进：Shift+Tab 向左缩进
nnoremap <S-Tab> <<

" 窗口
" 水平分割
nnoremap <Leader>sp <C-w>s
" 垂直分割
nnoremap <Leader>vs <C-w>v
" 窗口焦点切换
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wl <C-w>l
" 窗口位置切换
nnoremap <Leader>wH <C-w>H
nnoremap <Leader>wJ <C-w>J
nnoremap <Leader>wK <C-w>K
nnoremap <Leader>wL <C-w>L
nnoremap <Leader>wx <C-w>x
" 窗口均分
nnoremap <Leader>w= <C-w>=
" 关闭其他窗口
nnoremap <Leader>wo <C-w>o



" 取消搜索高亮
nnoremap <Leader>nh :nohl<CR>

"-------缓冲取标签页快捷键设定
" 反向缩进
nnoremap <s-tab> <<

nnoremap <Leader>h :bnext<cr>

nnoremap <Leader>l :bprev<cr>

nnoremap <Leader>x :bn<bar>bd #<cr> 



" 消除按键延迟
set timeoutlen=500

" 设置 leader 键为空格
let mapleader = " "

" jk 返回普通模式（插入 + 可视）
inoremap jk <Esc>

" ------------插入模式-------------- --

" ------------视觉模式-------------- --
" 选定行移动
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ------------普通模式-------------- --
" 反向缩进：Shift+Tab 向左缩进
nnoremap <S-Tab> <<

" 窗口
" 水平分割
nnoremap <Leader>sp <C-w>s
" 垂直分割
nnoremap <Leader>vs <C-w>v
" 窗口焦点切换
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wl <C-w>l
" 窗口位置切换
nnoremap <Leader>wH <C-w>H
nnoremap <Leader>wJ <C-w>J
nnoremap <Leader>wK <C-w>K
nnoremap <Leader>wL <C-w>L
nnoremap <Leader>wx <C-w>x
" 窗口均分
nnoremap <Leader>w= <C-w>=
" 关闭其他窗口
nnoremap <Leader>wo <C-w>o



" 取消搜索高亮
nnoremap <Leader>nh :nohl<CR>

"-------缓冲取标签页快捷键设定
" 反向缩进
nnoremap <s-tab> <<

nnoremap <Leader><Tab> :bnext<cr>

autocmd BufNewFile *.cmdn 0r ~/.config/nvim/note_template.cmdn
