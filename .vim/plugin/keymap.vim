
"消除按键延迟

set timeoutlen=300

"设置leader键
let mapleader = " "


" jj JJ 退回普通模式

inoremap jj <Esc>
inoremap JJ <Esc>
" 反向缩进
nnoremap <S-Tab> <<

nnoremap <C-l> :bnext<CR>

nnoremap <C-h> :bprev<CR>

nnoremap <C-x> :bn<Bar>bd #<CR> 
"leader键+e 切换打开netwr
nnoremap <Leader>e :call ToggleNetrw()<CR>
" 快捷键定义（可自行改为其他键，例如 <Leader>w）
nnoremap <Leader>w :call FocusNetrwOrBack()<CR>



" 通用模版：禁用 netrw 中的快捷键
function! s:customize_netrw_maps()
    " 将具体的映射规则填在这里
    " 例如：将 v 键设为『什么都不做』
     nnoremap <buffer> v <Nop>
     nnoremap <buffer> o <Nop>
    
     nnoremap <buffer> i <Nop>
endfunction

augroup netrw_customize
    autocmd!
    autocmd filetype netrw call s:customize_netrw_maps()
augroup END



function! ToggleNetrw()
    for w in range(1, winnr('$'))
        if getbufvar(winbufnr(w), '&filetype') == 'netrw'
            execute w . 'wincmd c'
            return
        endif
    endfor
    execute 'E'
endfunction

" 在 Netrw 和编辑窗口之间切换焦点
function! FocusNetrwOrBack()
    " 先找 netrw 窗口编号
    let netrw_win = 0
    for w in range(1, winnr('$'))
        if getbufvar(winbufnr(w), '&filetype') == 'netrw'
            let netrw_win = w
            break
        endif
    endfor
 
    if netrw_win == 0
        echo "没有打开的 Netrw 窗口"
        return
    endif

    " 如果当前就在 netrw 窗口，切回前一个窗口（通常是编辑窗口）
    if winnr() == netrw_win
        wincmd p
    else
        " 否则跳到 netrw 窗口
        execute netrw_win . 'wincmd w'
    endif
endfunction


