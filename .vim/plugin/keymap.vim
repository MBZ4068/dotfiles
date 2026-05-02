
"消除按键延迟

set timeoutlen=300

"设置leader键
let mapleader = " "


" jj JJ 退回普通模式

inoremap jj <esc>
inoremap jj <esc>
" 反向缩进
"-------缓冲取标签页快捷键设定
nnoremap <s-tab> <<

nnoremap <Leader>h :bnext<cr>

nnoremap <Leader>l :bprev<cr>

nnoremap <Leader>x :bn<bar>bd #<cr> 


nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
