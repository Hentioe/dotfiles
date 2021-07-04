" ---- METADATA ----
" Target: ~/.config/nixpkgs/home.nix
" Author: Hentioe (绅士喵)
" CreatedAt: 2019-03-27
" UpdatedAt: 2021-07-05
" ---- METADATA ----

" 剪切板
set clipboard+=unnamedplus
" 显示行号
set number
" 突出当前行
set cursorline
" 语法高亮
syntax on
" 保存快捷键
inoremap <c-l> <c-o>:w<cr>
nnoremap <c-l> :w<cr>
" 启用鼠标
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 显示括号匹配
set showmatch
" 启动文件系统/插件/缩进
filetype plugin indent on
" 设置缩进
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
" 自动读取外部更改
set autoread
" 显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 让vimrc配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
