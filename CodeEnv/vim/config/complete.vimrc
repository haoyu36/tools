" =====================
" Plugs Settings
" =====================

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
call vundle#begin()
call vundle#end()            " required

" plugs
Plugin 'VundleVim/Vundle.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-fugitive'
" Plugin 'git://git.wincent.com/command-t.git'
Plugin 'scrooloose/nerdtree'
Plugin 'powerline/powerline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'majutsushi/tagbar'
" Plugin 'nvie/vim-flake8'

" Plugin 'vim-syntastic/syntastic'
" Plugin 'davidhalter/jedi-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
" Plugin 'ivanov/vim-ipython'



" ERDree plug setting
map <F10> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$']

" Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap <F3> :TagbarToggle<CR>


" Plugin: ctrlpvim/ctrlp.vim 文件搜索
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_map = '<leader>ff'
" 相当于mru功能，show recently opened files
map <leader>fp :CtrlPMRU<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1


" 使用 ag 搜索
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif



" ====================
" 基础及排版设置
" ====================

" 修改leader键
let mapleader = ','
let g:mapleader = ','

" 开启语法高亮
syntax on

" history存储容量
set history=2000

" 检测文件类型
filetype on

" 针对不同的文件类型采用不同的缩进格式
filetype indent on

" 允许插件
filetype plugin on

" 启动自动补全
filetype plugin indent on

" 文件修改之后自动载入
set autoread

" 关闭交换文件
set noswapfile

" 忽略文件
set wildignore=*.swp,*.bak,*.pyc,*.class,.svn,*/.git/*,*/.DS_Store,*.o,*~

" 突出显示当前列
set cursorcolumn

" 突出显示当前行
set cursorline

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Enable folding
set foldmethod=indent
set foldlevel=99

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7

" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" Always show the status line - use 2 lines for the status bar
set laststatus=2

" 显示行号
set number

" 取消换行
set nowrap

" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

" 高亮search命中的文本
set hlsearch

" 打开增量搜索模式,随着键入即时搜索
set incsearch

" 搜索时忽略大小写
set ignorecase

" 有一个或以上大写字母时仍大小写敏感
set smartcase

" 缩进配置
set smartindent

" 打开自动缩进
set autoindent

" 设置Tab键的宽度        [等同的空格个数]
set tabstop=4

" 每一次缩进对应的空格数
set shiftwidth=4

" 按退格键时可以一次删掉 4 个空格
set softtabstop=4

" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab

" 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set expandtab

" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber

" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>


"==========================================
" others 其它设置
"==========================================

" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %

" 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu

" 增强模式中的命令行自动完成操作
set wildmenu

" 离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" 回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" quickfix window  s/v to open in split window,  ,gd/,jd => quickfix window => open it
autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><Enter><C-w>L
autocmd BufReadPost quickfix nnoremap <buffer> s <C-w><Enter><C-w>K

" command-line window
autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>


"==========================================
" 自定义建设置
"==========================================

" 关闭方向键, 强迫使用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" F2 行号开关行号，用于鼠标复制代码用
function! HideNumber()
  if(&relativenumber == &number)
    set relativenumber! number!
  elseif(&number)
    set number!
  else
    set relativenumber!
  endif
  set number?
endfunc
nnoremap <F2> :call HideNumber()<CR>

" 分屏窗口移动
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Map ; to : 用于快速进入命令行
" nnoremap ; :

" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /

" 进入搜索Use sane regexes"
nnoremap / /\v
vnoremap / /\v

" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" 去掉搜索高亮
noremap <silent><leader>/ :nohls<CR>

" 复制选中区到系统剪切板中
vnoremap <leader>y "+y

" kj 替换 Esc
inoremap kj <Esc>

" 上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" ==========================================
"  FileType Settings  文件设置
" ==========================================

" 具体编辑文件类型的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType javascript,html,css set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" for # indent, python文件中输入新行时#号注释不切回行首
autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#

" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun


" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为python
    if &filetype == 'python'
        call setline(1, "# -*- coding: utf-8 -*-")
        call setline(2, "# Author: haoyu")
    endif
    if &filetype == 'sh'
        call setline(1, "#!/bin/bash")
        call setline(2, "# Author: haoyu")
    endif

    normal G
    normal o
    normal o
endfunc

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 设置新文件的编码为 UTF-8
set encoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

colorscheme desert
let python_highlight_all=1
