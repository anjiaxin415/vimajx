""""""""""""""""""
" NGAGE
""""""""""""""""""
" System {{{
if has("win32")
    let $VIMFILES=$VIM."/vimfiles"
    " 解决MS中文乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    set fileencoding=chinese
    language messages zh_CN.utf-8
else
    let $VIMFILES=$HOME."/.vim"
    set backupdir=/tmp
    set directory=/tmp
endif
" Backup
set nobackup
set nowb
set noswapfile
" }}}
" Themes {{{
" +----------------------------+
" | abcdefghijklmnopqrstuvwxyz |
" | ABCDEFGHIJKLMNOPQRSTUVWXYZ |
" | 1234567890`~-_=+!@#$%^&*() |
" | [] {} <> .:,; ''"" \ | / ? |
" +----------------------------+
set guifont=PowerlineSymbols:h18    " 默认字体(for powerline)
"set guifont=Monaco:h18             " 默认字体
set linespace=2                     " 设置行高"

set cindent


colorscheme molokai "Ubuntu#300A24
syntax on

if has('gui_running')
    set background=light
else
    set background=dark
endif

"colorscheme solarized "Ubuntu#300A24


let g:molokai_original = 1
let g:rehash256 = 1

" }}}
" General {{{
"
" Set 3 lines to the cursor - when moving vertically using j/k
set so=2
" Sets how many lines of history VIM has to remember
set history=1024
" Set to auto read when a file is changed from the outside
set autoread
" Turn on the WiLd menu
set wildmenu
" A buffer becomes hidden when it is abandoned
set hid
" Configure backspace so it acts as it should act
set backspace=2
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set nowrap "Wrap lines
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" Always show current position
" Height of the command bar
set cmdheight=1
" Always show the status line
set laststatus=2
" Managing tabs
"set showtabline=2

" Encode
set encoding=utf8
set ffs=unix,dos,mac
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,euc-kr,gb18030,gbk,gb2312,cp936,big5,latin1,chinese

" Set extra options when running in GUI mode
if has("gui_running")
    set shortmess=atI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guitablabel=%M\ %t
endif

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif
" }}}

""""""""""""""""""
" MAP
""""""""""""""""""
" Globe {{{
"
" Map leader
let mapleader = ";"
let g:mapleader = ";"

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
" $ Del tab \t space
autocmd bufwritepre * sil! %s/\s\+$//e
" Remove the Windows ^M - when the encodings gets messed up
"
"
nmap <leader>z :Dox<cr>


" v-block
nmap <leader>v <c-v>

" copy & cut & paste
map <leader>y "+y
map <leader>x "+x
map <leader>p "+p

" Smart way to move between windows
"nmap <leader>w <c-w>

" sudo fast saving
nmap <leader>s :w !sudo tee %<cr>

" Tab
nmap <leader>tn :tabnew<cr>
nmap <leader>to :tabonly<cr>
nmap <leader>th :tabprevious<cr>
nmap <leader>tl :tabnext<cr>
nmap <leader>tv :vsplit new<cr>
nmap <leader>ts :split new<cr>


" Opens a new tab with the current buffer's path Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
"  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"""
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
"map <leader>n :cn<cr>
"map <leader>p :cp<cr>

set foldenable
augroup vimrc
    au BufReadPre * setlocal foldmethod=marker
    au BufWinEnter * if &fdm == 'marker' | setlocal foldmethod=manual | endif
augroup END
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" }}}

""""""""""""""""""
" FUNCTION
""""""""""""""""""
" <F11> - Full Windows {{{
" ubuntu: sudo apt-get install wmctrl
let g:fullscreen = 0
function! ToggleFullscreen()
    if g:fullscreen == 1
        let g:fullscreen = 0
        let mod = "remove"
    else
        let g:fullscreen = 1
        let mod = "add"
    endif
    call system("wmctrl -ir " . v:windowid . " -b " . mod . ",fullscreen")
endfunction
if has("win32")
    nnoremap <F11> <esc>:simalt ~x<CR>
    nnoremap <S-F11> <esc>:simalt ~r<CR>
else
    nnoremap <F11> :call ToggleFullscreen()<CR>
endif
" }}}
" <leader>6 - check the current file code Grammar (PHP) more {{{
function! CheckSyntax()
    if &filetype!="php"
        echohl WarningMsg | echo "Fail to check syntax! Please select the right file!" | echohl None
        return
    endif
    if &filetype=="php"
        " Check php syntax
        setlocal makeprg=\"php\"\ -l\ -n\ -d\ html_errors=off
        " Set shellpipe
        setlocal shellpipe=>
        " Use error format for parsing PHP error output
        setlocal errorformat=%m\ in\ %f\ on\ line\ %l
    endif
    execute "silent make %"
    set makeprg=make
    execute "normal :"
    execute "copen"
endfunction
autocmd FileType php nnoremap <leader>6 :call CheckSyntax()<CR>
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" }}}
" VisualSelection {{{
function! CmdLine(str) " CmdLine {{{
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction " }}}
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>
" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>
" }}}
" Don't close window, when deleting a buffer {{{
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Close the current buffer
map <leader>bd :Bclose<cr>
" Close all the buffers
map <leader>ba :1,1000 bd!<cr>
" }}}

""""""""""""""""""
" VUNDLE
""""""""""""""""""
" VUNDLE {{{
"
" au VimEnter * VundleInstall {{{
let hasVundle=1
let root = '$VIMFILES/bundle/vundle'
let src = 'http://github.com/gmarik/vundle.git'
if !isdirectory(expand(root))
    echo 'Installing Vundle...'
    exec '!mkdir -p '.root
    exec '!git clone '.src.' '.root
    let hasVundle=0
endif
" }}}

set rtp+=$VIMFILES/bundle/vundle/
call vundle#rc()

set nocompatible               " be iMproved
filetype off                   " required!

" let Vundle manage Vundle " required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github


" vim中使用git插件，提供G开头的一些命令：Gdiff Gstatus Gcommit -a等
Bundle 'tpope/vim-fugitive'
" 字符定位
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/nerdtree'
" html5的语法提示，排版
Bundle 'othree/html5.vim'
" js 排版问题
Bundle 'pangloss/vim-javascript'
" Ctrlp 模糊搜索文件 Ctrlp打开后control＋f 模糊搜索最近打开的文件
" control＋f 和 control＋b切换搜索模式
" 在没有搜索到的情况下可以 control＋y 新建文件
Bundle 'kien/ctrlp.vim'
" tab支持 自动补全使用tab
Bundle 'ervandew/supertab'
" 标签(html标签) tab自动补全
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

" 时光机 文件时光机, 可以查看同一个文件之前的历史内容 命令：Gun开头的命令
Bundle 'sjl/gundo.vim'
" 窗口管理
Bundle 'spolu/dwm.vim'
" 漂亮的状态栏 状态栏增强插件
Bundle 'Lokaltog/vim-powerline'
" 括号匹配高亮
Bundle 'kien/rainbow_parentheses.vim'
" 对齐缩进
Bundle 'nathanaelkane/vim-indent-guides'
" vim 支持ack搜索
Bundle 'mileszs/ack.vim'
"Bundle 'rking/ag.vim'
let g:ackprg = 'ag --nogroup --nocolor --column'

" 一键去除所有行尾空格
Bundle 'bronson/vim-trailing-whitespace'
" markdown 语法高亮和预览
Bundle 'plasticboy/vim-markdown'
" nginx配置文件语法高亮,常常配置服务器很有用
Bundle 'evanmiller/nginx-vim-syntax'
" 多光标选中修改 control+b+[j/k] 选中区域快进行操作
" 查找到对应的关键字 control＋n 选中相同查找到的关键字进行操作
Bundle 'terryma/vim-multiple-cursors'

"Bundle 'jnwhiteh/vim-golang'
"Bundle 'vexxor/phpdoc.vim'
"Bundle 'AndrewRadev/splitjoin.vim'
"Bundle 'mattn/zencoding-vim'
"Bundle 'tomasr/molokai'

Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'jiangmiao/auto-pairs'

" vim-scripts repos
"Bundle 'AutoComplPop'
Bundle 'OmniCppComplete'
Bundle "shawncplus/phpcomplete.vim"

"PHP手册
Bundle "ruanyl/vim-php-manual"


"
" vim-scripts repos
"Bundle 'AutoComplPop'
"Bundle 'OmniCppComplete'

" 需要ctags配合使用
" 打开vim的文件类型自动检测功能：filetype on
" 你的vim支持system()调用 linux发行版默认关闭
Bundle 'taglist.vim'

" html高亮匹配标签
Bundle 'MatchTag'

" 最近打开的文件
Bundle 'mru.vim'
Bundle 'txt.vim'
Bundle 'txt2tags'
Bundle 'php-doc'

Bundle 'altercation/vim-colors-solarized'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'gvim-colors-solarizedodlygeek/tabular'

" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...
filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" au VimEnter * BundleInstall {{{
if hasVundle == 0
    echo "Installing Bundles..."
    :BundleInstall
endif
" }}}
" }}} END

""""""""""""""""""
" PLUGINS
""""""""""""""""""
" powerline {{{
syn on
set t_Co=256
"set gfw=PowerlineSymbols\ for\ Powerline\ Medium
"set fillchars+=stl:\ ,stlnc:\
"let g:Powerline_symbols = 'fancy'
" }}}
" indent-guides {{{
set expandtab " Use spaces instead of tabs
"set smarttab " Be smart when using tabs ;)
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set ai "Auto indent
set si "Smart indent
"set cc=80
set ts=4 sw=4 et
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size=1
autocmd FileType html let g:indent_guides_guide_size=2
autocmd FileType html set ts=2 sw=2 et
autocmd FileType php set ts=4 sw=4 et
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
" }}}
" nerdcommenter {{{
let nerdshutup = 1
" }}}
" nerdtree [1,2] {{{
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize=23
nnoremap <leader>1 :NERDTreeToggle<CR>
nnoremap <leader>2 :NERDTreeFind<CR>
" }}}
" taglist [3] {{{
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
nnoremap <leader>3 :Tlist<CR>
" }}}
" gundo [4] {{{
let g:gundo_right = 1
let g:gundo_width = 60
let g:gundo_preview_bottom = 0
let g:gundo_preview_height = 40
nnoremap <leader>4 :GundoToggle<CR>
" }}}
" mru [5] {{{
nnoremap <leader>5 :MRU<CR>
" }}}
" supertab {{{
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
" }}}
" dwm {{{
"let g:dwm_map_keys=0
"set mouse=a ""enable the use of the mouse in all modes
"nmap <c-n> :DWM_New<CR>
" }}}
" txt {{{
au BufRead,BufNewFile *.txt set ft=txt
" }}}
" txt2tags {{{
au BufRead,BufNewFile *.t2t set ft=txt2tags
" }}}
" python {{{
"let python_highlight_all = 1
":Python2Syntax #Switch to Python 2 highlighting mode
":Python3Syntax #Switch to Python 3 highlighting mode
" }}}
" markdown <F5> {{{
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=mkd
autocmd FileType mkd set ts=2 sw=2 et
autocmd FileType mkd nmap <F5> :!/usr/bin/markdown % > <c-r>=expand('%:t:r').'.html'<cr><cr>
autocmd FileType mkd nmap <S-F5> :!/usr/bin/chromium-browser <c-r>=expand('%:t:r').'.html'<cr><cr>
"<div class="row">
"  <div class="span8">
"    <table class="table table-bordered table-condensed">
"      <thead>
"        <th style="width: 100%">x</th>
"      </thead>
"      <tbody>
"        <tr>
"          <td>x</td>
"        </tr>
"      </tbody>
"    </table>
"  </div>
"</div>
" }}}
" go <F5> {{{
"autocmd FileType go nmap <F5> :!/usr/bin/gccgo %; ./a.out<cr>
autocmd FileType go nmap <F5> :!go run %<cr>
" }}}
" YCM自动补全配置 {{{
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示

let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic
"nnoremap <leader>lo :lopen<CR>	"open locationlist
"nnoremap <leader>lc :lclose<CR>	"close locationlist
inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处
" }}}
"
"
"
"
let g:vimproc_dll_path=$VIMRUNTIME."/proc.dll"
let g:neocomplcache_enable_at_startup = 1

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"call vam#ActivateAddons(['neosnippet', 'neosnippet-snippets'])
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'


let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
"set error or warning signs
let g:syntastic_error_symbol = 'x'
let g:syntastic_warning_symbol = '!'
"whether to show balloons
let g:syntastic_enable_balloons = 1

let g:debuggerPort = 9000 "（该端口必须与xdebug.remote_port相同）
let g:debuggerMaxDepth = 5 "（代表数组调试深度配置）



"进行版权声明的设置
"添加或更新头
map <F4> :call TitleDet()<cr>'s
function AddTitle()
        call append(0,"/*=============================================================================")
        call append(1,"#")
        call append(2,"# Author: vaptu - vaptu@qq.com")
        call append(3,"#")
        call append(4,"# Last modified: ".strftime("%Y-%m-%d %H:%M"))
        call append(5,"#")
        call append(6,"# Filename: ".expand("%:t"))
        call append(7,"#")
        call append(8,"# Description: ")
        call append(9,"#")
        call append(10,"=============================================================================*/")
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf
        "更新最近修改时间和文件名
function UpdateTitle()
        normal m'
        execute '/# *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
        normal ''
        normal mk
        execute '/# *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
        execute "noh"
        normal 'k
        echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
        "判断前10行代码里面，是否有Last modified这个单词，
        "如果没有的话，代表没有添加过作者信息，需要新添加；
        "如果有的话，那么只需要更新即可
function TitleDet()
        let n=1
        "默认为添加
        while n < 10
            let line = getline(n)
            if line =~ '^\#\s*\S*Last\smodified:\S*.*$'
                call UpdateTitle()
                return
            endif
        let n = n + 1
        endwhile

        call AddTitle()
endfunction


set nocompatible " be iMproved
filetype off " required!



filetype plugin indent on " required!

set bs=2
set ts=4
set sw=4
set number
" shows row and column number at bottom right corner
set ruler

" For solarized plugin (color scheme)
" https://github.com/altercation/vim-colors-solarized
syntax enable
set background=dark
"colorscheme solarized

" NERDTree config

map <C-n> :NERDTreeToggle<CR> "按ctrl+n进行窗口的切换
let NERDTreeChDirMode=2 "选中root即设置为当前目录
let NERDTreeQuitOnOpen=1 "打开文件时关闭树
let NERDTreeShowBookmarks=1 "显示书签
let NERDTreeMinimalUI=1 "不显示帮助面板
let NERDTreeDirArrows=1 "目录箭头 1 显示箭头 0传统+-|号


"php 函数库
au FileType php call PHPFuncList()
function PHPFuncList()
set dictionary-=~/.vim/php_funclist.txt dictionary+=~/.vim/php_funclist.txt
set complete-=k complete+=k
endfunction

function! InsertTabWrapper()
    let col=col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<TAB>"
    else
        return "\<C-N>"
    endif
endfunction

inoremap <TAB> <C-R>=InsertTabWrapper()<CR>
