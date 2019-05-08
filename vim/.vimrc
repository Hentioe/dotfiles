" ---- METADATA ----
" Target: ~/.vimrc
" Author: Hentioe (绅士喵)
" CreatedAt: 2019-03-27
" UpdatedAt: 2019-05-08
" ---- METADATA ----

" 编码
set encoding=utf8
" 新分割窗口位于下方
set splitbelow
" JSON 注释支持
autocmd FileType json syntax match Comment +\/\/.\+$+
" 插件列表
call plug#begin('~/.vim/plugged')
Plug 'Chiel92/vim-autoformat'
" 片段引擎
Plug 'SirVer/ultisnips'
" 片段
Plug 'honza/vim-snippets'
" 注释
Plug 'scrooloose/nerdcommenter'
" 格式化
Plug 'sbdchd/neoformat'
" 文件树
Plug 'scrooloose/nerdtree'
" 状态栏
Plug 'vim-airline/vim-airline'
" 补全
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" 自动保存
Plug '907th/vim-auto-save'
" Crystal 语言
Plug 'rhysd/vim-crystal'
" Elixir 语言
Plug 'elixir-editors/vim-elixir'
" dracula 主题
Plug 'dracula/vim', { 'as': 'dracula' }
" 显示颜色代码
Plug 'chrisbra/colorizer'
" 高级搜索
Plug 'mileszs/ack.vim'
" 代码移动
Plug 'matze/vim-move'
" 代码对齐
Plug 'godlygeek/tabular'
" 搜索、替换和缩写单词
Plug 'tpope/vim-abolish'
" 对齐线
Plug 'Yggdroot/indentLine'
" Markdown 预览
Plug 'iamcco/markdown-preview.nvim'
" HTML 标签自动关闭
Plug 'alvan/vim-closetag'
" 显示版本控制差异
Plug 'mhinz/vim-signify'
" 单行/多行代码转换
Plug 'AndrewRadev/splitjoin.vim'
" 扩展/引号补全
Plug 'Raimondi/delimitMate'
" 文件图标（始终将此插件最后一个加载）
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
" 只剩下文件数的时候自动关闭 vim
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTree 忽略显示的文件/目录
let NERDTreeIgnore=["\.git$", "\.idea$"]
" 启动自动保存
let g:auto_save = 1
" 添加终端
nnoremap <F10> :split \| resize 8 \| term<cr>
" HTML ecr 模板文件类型
au BufRead,BufNewFile *.html.ecr set filetype=html
" 添加注释空格
let g:NERDSpaceDelims = 1
" 对齐注释
let g:NERDDefaultAlign = 'left'
