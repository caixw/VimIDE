"==============================================================================
" 自用的 vim 配置文件。适用以下版本:
" widows/linux 下的 Gvim8;
" macOS 下的 macvim 和 vim8
"
" Author:       caixw <https://github.com/caixw>
" Version:      0.4.2.20220928
" Licence:      MIT
" =============================================================================

" 设置不兼容 VI 模式，在增强模式下运行
set nocompatible



" 覆盖文件时不备份
set nobackup
" 不启用交换文件
"set noswapfile
" 保存文件格式
set fileformats=unix,dos
" 读文件时，使用的编码。前 2 个顺序不能错
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
" 菜单语言，必须要在 set encoding 之后,界面加载之前
set langmenu=zh_CN.utf-8
" 自动隐藏鼠标
set mousehide
" 右键点击时，弹出菜单
set mousemodel=popup
" 不显示菜单栏
set guioptions-=m
" 不显示工具栏
set guioptions-=T
" r 代表 right，就是在右侧显示滚动条
set guioptions+=r
" b 代表 bottom，就是不在下面加入滚动条
set guioptions-=b
" 高度
set lines=60
" 宽度
set columns=220
" 设定光标离窗口上下边界 3 行时窗口自动滚动
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
" 命令行按 tab 补全时，显示一个候选菜单
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
" 设置 browse 命令打开的目录，current 当前，buffer 当前 buffer 相同，last 上次的目录
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
" 为 C 程序提供自动缩进
set smartindent
set cindent
" 使用空格代替 tab.
set expandtab
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
" 显示一些不显示的空白字符
" 通过 set list 和 set nolist 控制是否显示或是用 set list! 切换显示
set listchars=tab:>-,eol:$,trail:-



if has("gui_running")
    if has("gui_gtk2")
        set guifont=Droid\ Sans\ Mono\ 12
        " 比英文字体大一点，这样汉字的间距就不会太大了
        "set guifontwide=Droid\ Sans\ 13
    elseif has("gui_kde")
        "set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
    elseif has("x11")
        "set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
    elseif has("gui_macvim")
        set guifont=monofur\ for\ Powerline:h15
        "set guifontwide=PingFang:h15
    elseif has("gui_kde")
        " todo
    elseif has("gui_win32")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h13
        "set guifontwide=Microsoft\ YaHei\ UI:h12
    else
        "set guifont=YaHei\ Consolas\ Hybrid:h10
    endif
endif

"==============================================================================
"========================== 开始加载插件
"==============================================================================

filetype off

call plug#begin('~/.vim/plugged')

" lsp 服务以及自动完成功能
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'


" 侧边树状文件夹浏览
Plug 'scrooloose/nerdtree'

" 侧边栏显示相关函数定义等，依赖 https://ctags.io/
Plug 'majutsushi/tagbar'

" Go 相关插件
Plug 'fatih/vim-go'

" 代码片段，需要 Python 支持
Plug 'SirVer/ultisnips'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'

" 多光标支持。
Plug 'terryma/vim-multiple-cursors'

" 缩进高亮，显示一条竖线
Plug 'Yggdroot/indentLine'

" 快速注释
Plug 'scrooloose/nerdcommenter'

" 显示 git 的更改内容
Plug 'airblade/vim-gitgutter'

" 对 EditorConfig 的支持
Plug 'editorconfig/editorconfig-vim'

" airline 状态栏美化。
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 一些好用的主题
Plug 'tomasr/molokai'
Plug 'Haron-Prime/evening_vim'
Plug 'vim-scripts/desertEx'
Plug 'lifepillar/vim-solarized8'

" 启动页面
Plug 'mhinz/vim-startify'

" 中文文档。
Plug 'asins/vimcdoc'

call plug#end()

filetype plugin indent on

syntax enable
syntax on

"==============================================================================
"======================== 开始插件配置
"==============================================================================

if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
    autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
    autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
    autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
endif


" NERDTree
" 打开文件后，关闭 nerdtree
" let NERDTreeQuitOnOpen=1
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=['.\.obj$', '.\.o$', '.\.so$', '.\.exe$', '.\.git$', '.\.swp$']
map <F2> :NERDTreeToggle<CR>
" 在 NERDTree 窗口中禁用 BD 命令。
autocmd FileType nerdtree cnoreabbrev <buffer> bd <nop>
" 当关闭得只剩下 NERDTree 一个窗口时，自动关闭 vim
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


" tagbar
let g:tagbar_width = 50
nmap <F1> :TagbarToggle<CR>
let g:tagbar_left =1
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
    \ 'ctagsargs' : '-sort -silent'
\ }


" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_sructs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'


let g:asyncomplete_auto_popup = 1


" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsSnippetDirectories=["ultisnippets"]


" editorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


" ariline
" 使用 powerline 的箭头，需要安装 powerline 字体，在未安装 powerline 字体的情况下，
" 可以将此值设置为 0，这将使用之后的这些默认的符号替换。
let g:airline_powerline_fonts = 1
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

" airline-tabline 扩展设计，若需要更专业的 buffer 列表显示插件，
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


" 启动画面
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
                \ '   适用于 Go 语言开发，由 caixw 整理发布！',
                \ ]


" 中文在斜体显示时，会比较怪异，统一去掉
let g:solarized_italics = 0


" 帮助语言为中文
set helplang=cn

colors solarized8
set background=dark

" 自动开启语法高亮
syn on


" 去除 linux 下菜单(包含右键菜单)乱码，放最后。
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

