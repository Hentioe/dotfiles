" ---- METADATA ----
" Target: ~/.vimrc
" Author: Hentioe (绅士喵)
" CreatedAt: 2019-03-27
" UpdatedAt: 2019-04-17
" ---- METADATA ----

" 编码
set encoding=utf8
set splitbelow
" JSON 注释支持
autocmd FileType json syntax match Comment +\/\/.\+$+
" 插件列表
call plug#begin('~/.vim/plugged')
Plug 'Chiel92/vim-autoformat'
" 代码片段
Plug 'honza/vim-snippets'
" 格式化
Plug 'sbdchd/neoformat'
" 文件树
Plug 'scrooloose/nerdtree'
" 状态栏
Plug 'vim-airline/vim-airline'
" 补全
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" 自动保存
Plug '907th/vim-auto-save'
" Crystal 语言
Plug 'rhysd/vim-crystal'
" Elixir 语言
Plug 'elixir-editors/vim-elixir'
" dracula 主题
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'chrisbra/colorizer'
Plug 'mileszs/ack.vim'
Plug 'matze/vim-move'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-abolish'
" 对齐线
Plug 'Yggdroot/indentLine'
" Markdown 预览
Plug 'iamcco/markdown-preview.nvim'
" 始终将此插件最后一个加载
Plug 'ryanoasis/vim-devicons'
call plug#end()
" 主题
color dracula
" 启动 NERDTree
autocmd vimenter * NERDTree
" NERDTree 显示隐藏文件
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" 文件树开关快捷键
map <C-n> :NERDTreeToggle<CR>
map <C-d> :NERDTreeCWD<CR>
" 只剩下文件数的时候自动关闭 vim
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTree 忽略显示的文件/目录
let NERDTreeIgnore=["\.git$", "\.idea$"]
" 启动自动保存
let g:auto_save = 1
" 添加终端
nnoremap <F10> :split \| resize 8 \| term<cr>
