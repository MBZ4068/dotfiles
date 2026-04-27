" ========== Netrw 文件浏览器优化 ==========
" 关闭 Netrw 的 banner（提示信息），让界面更简洁

" Netrw 打开文件为上一个使用的分屏
let g:netrw_browse_split = 4

" 设置树形显示风格
let g:netrw_liststyle = 3 

" 设置窗口宽度（单位：字符）
let g:netrw_winsize = 20
let g:netrw_banner = 0
"

" 可选：启动 Vim 时若不带文件名，自动打开 Netrw
" let g:netrw_brrow = 1

"使用垂直分屏打开netrw
command! E execute  'Vex ' . fnameescape(expand('%:p:h') == '' ? '~' : expand('%:p:h')) 

" ========== 自动打开 / 关闭 Netrw ==========
" 1. 打开 Vim 时自动垂直分屏 Netrw（如果没有其他文件窗口）
augroup AutoNetrw
    autocmd!
    autocmd VimEnter * if argc() > 0 | execute 'E' | vertical resize 20 | wincmd l | endif
augroup END

" 2. 当只剩下一个 Netrw 窗口时，自动退出 Vim
augroup AutoCloseNetrw
    autocmd!
    " 每次进入窗口时检查：如果只剩一个窗口且该窗口是 Netrw，则退出
    autocmd WinEnter * if winnr('$') == 1 && &filetype == 'netrw' | quit | endif
augroup END

augroup netrw_local_opts
    autocmd!
    autocmd FileType netrw setlocal winfixwidth
augroup END
