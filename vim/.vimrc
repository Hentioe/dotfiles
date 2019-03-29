" ---- METADATA ----
" Target: ~/.vimrc
" Author: Hentioe (绅士喵)
" CreatedAt: 2019-03-27
" UpdatedAt: 2019-03-29
" ---- METADATA ----

" 编码
set encoding=utf8
set splitbelow 
" omni 补全
set omnifunc=syntaxcomplete#Complete
autocmd FileType json syntax match Comment +\/\/.\+$+
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'rhysd/vim-crystal'
Plug 'elixir-editors/vim-elixir'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'chrisbra/colorizer'
Plug 'mileszs/ack.vim'
Plug 'matze/vim-move'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-abolish'
Plug 'Yggdroot/indentLine'
" Markdown 预览
Plug 'iamcco/markdown-preview.nvim'
" 始终将此插件最后一个加载
Plug 'ryanoasis/vim-devicons'
call plug#end()
" 启动 derdtree
autocmd vimenter * NERDTree
" 显示隐藏文件
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" 主题
" colorscheme afterglow
color dracula
" 文件树开关快捷键
map <C-n> :NERDTreeToggle<CR>
" 
map <C-d> :NERDTreeCWD<CR>
" 只剩下文件数的时候自动关闭 vim
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
let NERDTreeIgnore=["\.git$", "\.idea$"]
" 自动格式化 Crystal 代码
let g:crystal_auto_format=1
" open quickfix window automatically when AsyncRun is executed
" " set the quickfix window 6 lines height.
let g:asyncrun_open = 6
"
" " ring the bell to notify you job finished
let g:asyncrun_bell = 1
" 添加终端
nnoremap <F10> :split \| resize 8 \| term<cr>
