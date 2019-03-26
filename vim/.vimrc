" ---- METADATA ----
" Target: ~/.vimrc
" Author: Hentioe(绅士喵)
" CreatedAt: 2019-03-27
" UpdatedAt: 2019-03-17
" ---- METADATA ----

" pathogen 插件管理器
execute pathogen#infect()
filetype plugin indent on
" 启动 derdtree
autocmd vimenter * NERDTree
" 显示隐藏文件
let NERDTreeShowHidden=1
