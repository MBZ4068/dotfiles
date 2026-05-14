" ~/.vimrc
set nocompatible          
filetype plugin indent on 
syntax on                

let g:plug_dir= expand('~/vim-plugins/plugged')
if !isdirectory(g:plug_dir)
  call mkdir (g:plug_dir, 'p')
  echo "创建了插件文件夹：" . g:plug_dir  
endif 
set termguicolors
" 插件列表开始，可指定插件存放目录
call plug#begin(g:plug_dir)
  " 在此处列出你需要的插件，格式为：Plug '用户名/仓库名'
  Plug 'yianwillis/vimcdoc'            "汉化文档
  Plug 'lilydjwg/fcitx.vim'         "自动切换中文输入法软件
  Plug 'tpope/vim-fugitive'              " Git 集成工具
  Plug 'ap/vim-buftabline'            " 标签页工具
  "Plug 'git@gitee.com:mbz4068/iceberg'
  Plug 'bluz71/vim-nightfly-guicolors'       " 颜色主题
  "代码补全方向的插件
  Plug 'neoclide/coc.nvim',{'do':'npm ci'}
  " 引号等配对的插件
  Plug 'Raimondi/delimitMate'
  " 缩进线
  Plug 'Yggdroot/indentLine'
  "文件树插件
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  "美化状态栏
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='ayu_dark'
"以上都是有关于fern的插件
"插件列表结束
call plug#end()

" 设置颜色主题
silent! colorscheme nightfly


" ==================== coc.nvim 基础设置 ====================
" 让 <M-j> 用来在补全菜单中移动
inoremap <silent><expr> <M-j>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<M-j>" :
      \ coc#refresh()
inoremap <expr><M-k> coc#pum#visible() ? coc#pum#prev(1) : "\<M-k>"

"<Tab> 确认选中项
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"

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
      \ 'coc-vimlsp',
      \ 'coc-json'
      \ ]
" 注：coc-clangd → C/C++/Make；coc-pyright → Python；coc-sumneko-lua → Lua；coc-sh → Shell
