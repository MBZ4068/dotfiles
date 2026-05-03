
"消除按键延迟

set timeoutlen=300

"设置leader键
let mapleader = " "


" jj JJ 退回普通模式

inoremap jj <esc>
inoremap jj <esc>

" leader 的一些加速的快捷键
nnoremap <Leader>4 $
nnoremap <Leader>q :quit<cr>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>wq :wq<cr>





" 反向缩进
"-------缓冲取标签页快捷键设定
nnoremap <s-tab> <<

nnoremap <Leader>h :bnext<cr>

nnoremap <Leader>l :bprev<cr>

nnoremap <Leader>x :bn<bar>bd #<cr> 


" 打开 / 关闭的快捷键（推荐用 Ctrl+n）
nnoremap <Leader>e :NERDTreeFind <CR>
