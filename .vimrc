" ~/.vimrc
set nocompatible          
filetype plugin indent on 
syntax on                
"设置github加速
let g:plug_dir= expand('~/vim-plugins/plugged')

if !isdirectory(g:plug_dir)
  call mkdir (g:plug_dir, 'p')
  echo "创建了插件文件夹：" . g:plug_dir
endif 
set termguicolors
" 插件列表开始，可指定插件存放目录
call plug#begin(g:plug_dir)
" 在此处列出你需要的插件，格式为：Plug '用户名/仓库名'
Plug 'git@gitee.com:mbz4068/fcitx.vim'         "自动切换中文输入法软件
Plug 'git@gitee.com:mbz4068/vim-fugitive'              " Git 集成工具
Plug 'git@gitee.com:mbz4068/vim-buftabline'            " 标签页工具
"Plug 'git@gitee.com:mbz4068/iceberg'
Plug 'git@gitee.com:mbz4068/vim-nightfly-colors'       " 颜色主题
"代码补全方向的插件
Plug 'git@gitee.com:mbz4068/coc.nvim'
" 引号等配对的插件
Plug 'git@gitee.com:mbz4068/delimitMate'
" 插件列表结束
call plug#end()

" 设置颜色主题
colorscheme nightfly


" ==================== coc.nvim 基础设置 ====================
" 让 <Tab> 用来在补全菜单中移动
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" 回车键确认选中项，或正常换行
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" ==================== 指定需要自动安装的语言扩展 ====================
let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ 'coc-pyright',
      \ 'coc-sumneko-lua',
      \ 'coc-sh',
      \ 'coc-vimlsp'
      \ ]
" 注：coc-clangd → C/C++/Make；coc-pyright → Python；coc-sumneko-lua → Lua；coc-sh → Shell
