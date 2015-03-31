"==============================================================================
" 自用的vim配置文件。适用gvim7.4和最新版的MacVim
"
" Author:       caixw <https://github.com/caixw>
" Version:      0.3.20.150331
" Licence:      MIT
" =============================================================================

" 设置不兼容VI模式，在增强模式下运行
set nocompatible



" 覆盖文件时不备份
set nobackup
" 不启用交换文件
"set noswapfile
" 保存文件格式
set fileformats=unix,dos
" 读文件时，使用的编码。前2个顺序不能错
set fileencodings=ucs-bom,utf-8,cp936,gb2312,gb18030,gbk
" 保存时，使用的编码
set fileencoding=utf-8
" 程序使用的编码
set encoding=utf-8
" 终端上使用的编码
set termencoding=utf-8
" 记录历史行数
set history=500
" 自动切换目录
set autochdir
" 默认不区分大小写
"set noignorecase



let $LANG='zh_CN.UTF-8'
" 菜单语言，必须要在 set encoding之后,界面加载之前
set langmenu=zh_CN.utf-8
" 自动隐藏鼠标
set mousehide
" 右键点击时，弹出菜单
set mousemodel=popup
" 不显示菜单栏
set guioptions-=m
" 不显示工具栏
set guioptions-=T
" r代表right，就是在右侧显示滚动条
set guioptions+=r
" b代表bottom，就是不在下面加入滚动条
set guioptions-=b
" 窗口位置
winpos 240 0
" 高度
set lines=60
" 宽度
set columns=120
" 设定光标离窗口上下边界3行时窗口自动滚动
set scrolloff=3
" 高亮显示当前行
set cursorline
" 高亮显示当前列
set cursorcolumn
" 显示行号
set nu
" 搜索时高亮关键字
set hlsearch
" 搜索时逐字高亮
"set incsearch
" 命令行按tab补全时，显示一个候选菜单
set wildmenu
" 高亮显示匹配的符号，大括号什么的
set showmatch
" 右下角显示光标状态的行
set ruler
" 左下角显示当前的模式
set showmode
" 显示当前输入的命令
set showcmd
" 弹出框样式，比如自动补全的下拉框。
highlight Pmenu    guibg=darkgrey  guifg=black
highlight PmenuSel guibg=lightgrey guifg=black
" 设置borwse命令打开的目录，current当前，buffer当前buffer相同，last上次的目录
set browsedir=last
" 可折叠 foldenable/nofoldenable
set foldenable
" manual    手动折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的内容进行折叠
" marker    使用标记款待折叠，默认标记为{{{和}}}
set foldmethod=syntax
setlocal foldlevel=1
" 默认不折叠
set foldlevelstart=99
" 按空格折叠代码
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>



" 继承前一行的缩进方式
set autoindent
" 为C程序提供自动缩进
set smartindent
set cindent
" 使用space代替tab.
set expandtab
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
" 显示一些不显示的空白字符
" 通过 set list和 set nolist控制是否显示或是用set list!切换显示
set listchars=tab:>-,eol:$,trail:-



if has("gui_running")
    if has("gui_gtk2")
        set guifont=Droid\ Sans\ Mono\ 12
        " 比英文字体大一点，这样汉字的间距就不会太大了
        set guifontwide=Droid\ Sans\ 13
    elseif has("gui_kde")
        "set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
    elseif has("x11")
        "set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
    elseif has("gui_macvim")
        set guifont=Monaco:h13
    elseif has("gui_kde")
        " todo
    elseif has("gui_win32")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h13
        set guifontwide=Microsoft\ YaHei\ UI:h12
    else
        "set guifont=YaHei\ Consolas\ Hybrid:h10
    endif
endif

"==============================================================================
"========================== start Vundle
"==============================================================================

filetype off

" 此处规定Vundle的路径
if has("win32")
    set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$VIM/vimfiles/bundle')
else
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin('~/.vim/bundle/')
endif

Plugin 'gmarik/Vundle.vim'

" 所有插件在Filetype之间添加。可以是以下三种形式：
" vim.org上的脚本名                 Plugin php
" Plugin github上的作者/项目名称    Plugin gmark/vundle
" Plugin 一个完整的Git路径          Plugin git://git.wincent.com/commit.git
" Vundle常用指令
" :PluginList                       列出已经安装的插件
" :PluginInstall                    安装所有配置文件中的插件
" :PluginInstall!                   更新所有插件
" :PluginSearch                     搜索插件
" :PluginClean!                     根据配置文件删除插件

" CSS颜色值背景显示定义的颜色
Plugin 'skammer/vim-css-color'

" html5高亮
Plugin 'othree/html5.vim'

" JS高亮及HTML/JS混排缩进改善
Plugin 'pangloss/vim-javascript'

" php文档产生工具
Plugin 'vim-scripts/PDV--phpDocumentor-for-Vim'
autocmd FileType php nnoremap <C-i> :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <C-i> :call PhpDocRange()<CR>

" emmet 中文介绍http://www.zfanw.com/blog/zencoding-vim-tutorial-chinese.html
Plugin 'mattn/emmet-vim'

" 侧边树状文件夹浏览
Plugin 'scrooloose/nerdtree'
let NERDTreeHighlightCursorline=1
" 打开文件后，关闭nerdtree
" let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['.\.obj$', '.\.o$', '.\.so$', '.\.exe$', '.\.git$', '.\.swp$']
map <F2> :NERDTreeToggle<CR>
" 在nerdtree窗口中禁用BD命令。
autocmd FileType nerdtree cnoreabbrev <buffer> bd <nop>
" 当关闭得只剩下nerdtree一个窗口时，自动关闭vim
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
function! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
            if winnr("$") == 1
                q
            endif
        endif
    endif
endfunction

" 侧边栏显示相关函数定义等，依赖http://ctags.sourceforge.net/
Plugin 'majutsushi/tagbar'

let g:tagbar_width = 30
nmap <F1> :TagbarToggle<CR>
let g:tagbar_left =1

" golang相关插件
Plugin 'fatih/vim-go'
let g:go_highlight_build_constraints = 1

" 代码错误检测 若PHP，需要PHP.exe在PATH环境变量中，其它应该也类似
Plugin 'scrooloose/syntastic'
" 语法错误
let g:syntastic_error_symbol = ">>"
let g:syntastic_warning_symbol = ">"
" 语法风格错误
let g:syntastic_style_error_symbol="✗"
let g:syntastic_style_warning_symbol="⚠"


" 代码片段，需要python支持
 Plugin 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsSnippetDirectories=["ultisnippets"]
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" YCM插件。 windows安装麻烦，而且如果有msvcr90.dll的话，还有冲突
if !has("gui_win32")
    Plugin 'Valloric/YouCompleteMe'
    " 设置成c-n，避免与ultisnips相关快捷键冲突。
    let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
endif

" 多光标支持。
Plugin 'terryma/vim-multiple-cursors'

" 缩进高亮，显示一条竖线
Plugin 'Yggdroot/indentLine'

" 快速注释
Plugin 'scrooloose/nerdcommenter'

" 显示git的更改内容
Plugin 'airblade/vim-gitgutter'

" 对git命令的包装
Plugin 'tpope/vim-fugitive'

" airline 状态栏美化。
Plugin 'bling/vim-airline'
" 使用powerline的箭头，需要安装powerline字体，在未安装powerline字体的情况下，
" 可以将此值设置为0，这将使用之后的这些默认的符号替换。
let g:airline_powerline_fonts = 0
if g:airline_powerline_fonts == 0
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep = '▶'
    let g:airline_left_alt_sep = '❯'
    let g:airline_right_sep = '◀'
    let g:airline_right_alt_sep = '❮'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '§'
    let g:airline_symbols.whitespace = 'Ξ'
    let g:airline_symbols.readonly = ''
endif

let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : '标准',
      \ 'i'  : '插入',
      \ 'R'  : '替换',
      \ 'c'  : '命令行',
      \ 'v'  : '可视',
      \ 'V'  : '可视',
      \ '' : '可视',
      \ 's'  : '选择',
      \ 'S'  : '选择',
      \ '' : '选择',
      \ }

set laststatus=2

" airline-tabline扩展设计，若需要更专业的buffer列表显示插件，
" 可以使用 techlivezheng/vim-plugin-minibufexpl 插件！
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamemod = ':p:t' " 只显示文件名，不显示路径内容。

if g:airline_powerline_fonts == 0
    let g:airline#extensions#tabline#left_sep = '▶'
    let g:airline#extensions#tabline#left_alt_sep = '❯'
    let g:airline#extensions#tabline#right_sep = '◀'
    let g:airline#extensions#tabline#right_alt_sep = '❮'
endif

" 一些好用的主题
Plugin 'tomasr/molokai'

" 启动页面
Plugin 'mhinz/vim-startify'
let g:startify_custom_header = [
                \ '   __      ___              _  _______     _________ ',
                \ '   \ \    / (_)            | | | |____ \  | |_______|',
                \ '    \ \  / / _ _ __ ___    | | | |    | \ | |_______ ',
                \ '     \ \/ / | | `_ ` _ \   | | | |    | | | |_______|',
                \ '      \  /  | | | | | | |  | | | |____| | | |_______ ',
                \ '       \/   |_|_| |_| |_|  |_| |_|_____/  |_|_______|',
                \ '',
                \ '                      https://github.com/caixw/VimIDE',
                \ '',
                \ ]
let g:startify_custom_footer = [
                \ '',
                \ '',
                \ '   适用于Go和PHP语言开发，由caixw整理发布！',
                \ ]


" 中文文档。
Bundle 'asins/vimcdoc'
" 帮助语言为中文
set helplang=cn

call vundle#end()

filetype indent on
filetype plugin on
"==============================================================================
"======================== end Bundle
"==============================================================================

colors molokai
set background=dark

" 自动开启语法高亮
syn on
" 映射代码实例的快捷键
imap <C-u> <C-x><C-o>

" 去除linux下菜单(包含右键菜单)乱码，放最后。
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
