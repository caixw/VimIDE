"==============================================================================
" gvim的配置文件，部分内容只能在gvim下使用，不保证在vim模式下能全部启作用！
"
" 需要安装以下程序：
" gocode:     /nsf/gocode依赖此程序
" 安装：go get github.com/nsf/gocode
" windows 用安装不会出现一个命令窗口
" go get -u -ldflags -H=windowsgui github.com/nsf/gocode
"
" ctags:     tagbar依赖些程序
" http://ctags.sourceforge.net/
"
" gotags:    golang版本tagbar
" 安装：get github.com/jstemmer/gotags
"
" python27   UltiSnips依赖此
" windows如果是以python/dyn选项编译的，需要另外安装python,phthon3各个版本安装
" 后，脚本都出错。python27可以正常使用。
"
" Author:       caixw <xnotepad@gmail.com>
" Version:      0.1
" Licence:      MIT
" Last Change:  2014-05-08
" =============================================================================

" 设置不兼容VI模式，在增强模式下运行
set nocompatible


" 覆盖文件时不备份
set nobackup
" 不启用交换文件
set noswapfile
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
" 帮助语言为中文
set helplang=cn
" 窗口位置
winpos 240 0
" 自动隐藏鼠标
set mousehide
" 使用全局的剪贴板
set guioptions+=a
" 不显示菜单栏
set guioptions-=m
" 不显示工具栏
set guioptions-=T
" r代表right，就是在右侧显示滚动条
set guioptions+=r
" b代表bottom，就是不在下面加入滚动条
set guioptions-=b
" 高度
set lines=60
" 宽度
set columns=150
" 设定光标离窗口上下边界 5 行时窗口自动滚动
set scrolloff=3
" 高亮显示当前行
set cursorline
" 高亮显示当前列
set cursorcolumn
" 显示行号
set nu
" 搜索时高亮关键字
set hlsearch
" 高亮显示匹配的符号，大括号什么的
set showmatch
" 右下角显示光标状态的行
set ruler
" 左下角显示当前的模式
set showmode
" 显示当前输入的命令
set showcmd
" 设置borwse命令打开的目录，current当前，buffer当前buffer相同，last上次的目录
set browsedir=last
" 可折叠
set foldenable
" manual    手动折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的内容进行折叠
" marker    使用标记款待折叠，默认标记为{{{和}}}
set foldmethod=syntax
set foldlevel=10
" 按空格折叠代码
nmap <space> za


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
"显示一些不显示的空白字符
set listchars=tab:>-,eol:$,trail:-


if has("gui_running")
    if has("gui_gtk2")
        set guifont=Droid\ Sans\ Mono\ 10
        " 比英文字体大一点，这样汉字的间距就不会太大了
        set guifontwide=Droid\ Sans\ 12
    elseif has("gui_photon")
        "set guifont=Courier\ New:s11
    elseif has("gui_kde")
        "set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
    elseif has("x11")
        "set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
    elseif has("gui_macvim")
        "set set guifont=Droid_Sans_Mono:h1
    elseif has("gui_win32")
        set guifont=YaHei\ Consolas\ Hybrid:h10
    else
        set guifont=YaHei\ Consolas\ Hybrid:h10
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
    call vundle#begin('~/.vim/bundle/Vundle.vim/')
endif

Plugin 'gmarik/Vundle.vim'

" 所有插件在Filetype之间添加。可以是以下三种形式：
" vim.org上的脚本名             Plugin php
" Plugin git上的作者/项目名称   Plugin gmark/vundle
" Plugin 一个完整的Git路径      Plugin git://git.wincent.com/commit.git
" Vundle常用指令
" :PluginList                   列出已经安装的插件
" :PluginInstall                安装所有配置文件中的插件
" :PluginInstall!               更新所有插件
" :PluginSearch                 搜索插件
" :PluginClean!                 根据配置文件删除插件

" C++ STL高亮
Plugin 'Mizuchi/STL-Syntax'
" CSS颜色值背景显示定义的颜色
Plugin 'skammer/vim-css-color'
" html5高亮
Plugin 'othree/html5.vim'
" markdown文档高亮
Plugin 'plasticboy/vim-markdown'
" JS高亮及HTML/JS混排缩进改善
Plugin 'pangloss/vim-javascript'
" jquery高亮
Plugin 'vim-scripts/jQuery'
au BufRead,BufNewFile *.js set ft=jquery
" golang语法高亮，与go/misc/vim下内容一样
Plugin 'jnwhiteh/vim-golang'

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
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['.\.obj$', '.\.o$', '.\.so$', '.\.exe$', '.\.git$']
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

" golang 的自动补全 需要go get github.com/nsf/gocode
" vim-gocode是nsf/gocode/vim的增强版本，但是linux出现vim-gocode不可使用的情况
if has("win32")
    Plugin 'Blackrush/vim-gocode'
else
    Plugin 'nsf/gocode', {'rtp': 'vim/'}
endif

" 侧边栏显示相关函数定义等，依赖http://ctags.sourceforge.net/
Plugin 'majutsushi/tagbar'
nmap <F1> :TagbarToggle<CR>
let g:tagbar_left =1
" 定义go语言的tagbar 需要go get github.com/jstemmer/gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" 代码错误检测 若PHP，需要PHP.exe在PATH环境变量中，其它应该也类似
Plugin 'scrooloose/syntastic'
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'

" 代码片段，需要python3支持
 Plugin 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" 代码片段的定义，支持ultisnips和snippets
Plugin 'honza/vim-snippets'

" 缩进高亮，显示一条竖线
Plugin 'Yggdroot/indentLine'

" buffer list
Plugin 'techlivezheng/vim-plugin-minibufexpl'
hi MBENormal               guifg=#808080 guibg=fg
hi MBEChanged              guifg=#CD5907 guibg=fg
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
hi MBEVisibleChanged       guifg=#F1266F guibg=fg
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg

" airline 状态栏美化，状态栏箭头显示，需要特殊字体
Plugin 'bling/vim-airline'
set laststatus=2

" 主题 molokai
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
                \ '',
                \ ]
let g:startify_custom_footer = [
                \ '',
                \ '',
                \ '   适用于Go和PHP语言开发，由caixw整理发布！',
                \ ]

call vundle#end()

filetype indent on
filetype plugin on
"==============================================================================
"======================== end Bundle
"==============================================================================

colors molokai              " 配色方案：desert, evening, molokai
syn on                      " 自动开启语法高亮
imap <C-u> <C-x><C-o>
