" ---- METADATA ----
" Target: /usr/share/nvim/sysinit.vim
" Author: Hentioe(绅士喵)
" CreatedAt: 2019-03-27
" UpdatedAt: 2019-03-17
" ---- METADATA ----

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
" 设置缩进
set tabstop=4 shiftwidth=4 expandtab
" 粘贴模式
set paste
" 显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 让vimrc配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
