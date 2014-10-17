VimIDE
======

自用的一个vim配置文件，针对gvim，不保证vim下能全部正常使用。适用于Go与PHP。
不断更新中...



###依赖的软件

#### /nsf/gocode
Go语言的代码补全依赖些软件，直接使用go的安装命令安装即可：

    go get github.com/nsf/gocode

需要将gocode的目录放到path环境变量中。

windows用户若不想一直有个命令行窗口存在，可以带上以下参数安装：

    go get -u -ldflags -H=windowsgui github.com/nsf/gocode

#### ctags:
majutsushi/tagbar依赖些程序，可从以下地方获取安装程序

    http://ctags.sourceforge.net/

#### gotags:
tagbar的golang支持，可用以下命令安装：

    go get github.com/jstemmer/gotags

#### python
UltiSnips依赖Python2或是Python3，若vim编译时是以python/dyn形式编译的，则需要
另外安装python。windows安装Python3，一直提示各种错误，但是python27可以。

#### powerline-fonts
若需要使状态栏的箭头有特殊的效果，需要安装powerline-fonts的字体。linux下安装方式如下：

    cd ~/.fonts
    git clone https://github.com/Lokaltog/powerline-fonts
    wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
    wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    # Merge the contents of 10-powerline-symbols.conf to ~/.fonts.conf
    fc-cache -vf ~/.fonts

windows下，则直接将https://github.com/Lokaltog/powerline-fonts 下的字体安装下即可。


###安装


#### windows
将目录下的vimrc.vim复制到Vim根目录下，重命名为_vimrcwindows7之后的版
本，可以使用mklink创建一个链接到vimrc.vim。

    mklink  _vimrc e:\xxx\VimIDE\vimrc.vim

    cd vimfiles/bundle/
    git clone https://github.com/gmarik/Vundle.vim
    vim +PluginIntall


#### linux
将vimrc.vim复制到~/下，重命名为.vimrc。或是使用ln命令做一个符号链接到vimrc.vim文件。

    ln -s ~/project/VimIDE/vimrc.vim ~/.vimrc

    cd ~/.vim/bundle/
    git clone https://github.com/gmarik/Vundle.vim
    vim +PluginIntall

#### snippets
修改了部分go.snippets，可以通过在vim-snippets/snippets/下用mklink(ln)命令创建到go.snippets的映射，具体操作参数上面的方式

