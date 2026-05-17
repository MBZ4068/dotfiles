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



