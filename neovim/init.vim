" ---- METADATA ----
" Target: ~/.config/nvim/init.vim
" Author: Hentioe (绅士喵)
" CreatedAt: 2019-03-27
" UpdatedAt: 2019-07-14
" ---- METADATA ----

" --- VIM 内置 ---
" 文件编码
set encoding=utf8
" 新分割窗口位于下方
set splitbelow
" JSON 注释支持
autocmd FileType json syntax match Comment +\/\/.\+$+
" --- 插件列表 ----
call plug#begin('~/.config/nvim/plugged')
" Crystal 语言
Plug 'rhysd/vim-crystal'
" Elixir 语言
Plug 'elixir-editors/vim-elixir'
" Rust 语言
Plug 'rust-lang/rust.vim'
" Racket 语言
Plug 'wlangstroth/vim-racket'
" Reason 语言
Plug 'reasonml-editor/vim-reason-plus'
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 自动保存
Plug '907th/vim-auto-save'
" dracula 主题
Plug 'dracula/vim', { 'as': 'dracula' }
" 显示颜色代码
Plug 'chrisbra/colorizer'
" 高级搜索
Plug 'mileszs/ack.vim'
" 增量搜索
Plug 'haya14busa/incsearch.vim'
" 附加文本对象
Plug 'wellle/targets.vim'
" 对齐表格
Plug 'dhruvasagar/vim-table-mode'
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
" 单词翻译
Plug 'voldikss/vim-translate-me'
" HTML 标签自动关闭
Plug 'alvan/vim-closetag'
" 显示版本控制差异
Plug 'mhinz/vim-signify'
" 单行/多行代码转换
Plug 'AndrewRadev/splitjoin.vim'
" 括号/引号补全
Plug 'Raimondi/delimitMate'
" 文件图标（始终将此插件最后一个加载）
Plug 'ryanoasis/vim-devicons'
call plug#end()
" --- 主题 ---
color dracula
" --- 标签行 ---
" 启动标签行
let g:airline#extensions#tabline#enabled = 1
" 显示缓冲区编号
let g:airline#extensions#tabline#buffer_nr_show = 0
" 截断非活动缓冲区名称长度
let g:airline#extensions#tabline#fnametruncate = 16
" 折叠父级目录
let g:airline#extensions#tabline#fnamecollapse = 2
" 访问缓冲区
let g:airline#extensions#tabline#buffer_idx_mode = 1
" 仅显示尾部（除非出现同名文件）
let g:airline#extensions#tabline#formatter = 'unique_tail'
" 忽略的模式（主要添加了各种 Shell）
let airline#extensions#tabline#ignore_bufadd_pat =
            \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree|bash|zsh|fish'
" 关闭缓冲区时保留窗口
let airline#extensions#tabline#middle_click_preserves_windows = 1
" --- NERDTree ---
" 启动 NERDTree
autocmd vimenter * NERDTree
" 显示隐藏文件
let NERDTreeShowHidden=1
" 修改默认目录箭头
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" 状态栏显示
let g:NERDTreeStatusline = 'NERD'
" 只剩下文件数的时候自动关闭 vim
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 忽略显示的文件/目录
let NERDTreeIgnore=["\.git$", "\.idea$"]
" --- 自动保存 ---
" 启用自动保存
let g:auto_save = 1
" --- NERDCommenter ---
" 添加注释空格
let g:NERDSpaceDelims = 1
" 对齐注释
let g:NERDDefaultAlign = 'left'
" --- 文件类型 ---
" ecr HTML 模板文件类型
au BufRead,BufNewFile *.html.ecr set filetype=html
" --- 杂项 ---
" 添加终端
nnoremap <F10> :split \| resize 8 \| term<cr>
