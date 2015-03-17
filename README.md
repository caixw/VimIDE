VimIDE
======

自用的一个vim配置文件，针对gvim，不保证vim下能全部正常使用。适用于Go与PHP。
![screenshot](https://raw.github.com/caixw/VimIDE/master/images/screenshot.png)



### 依赖的软件

#### vim-go
vim-go中依赖的软件可以运行:GoInstallBinaries命令检测，缺失的都会提示。
确保go环境以及git和hg已经安装，go get依赖这仨！

#### python
UltiSnips依赖Python2或是Python3，若vim编译时是以python/dyn形式编译的，
则需要另外安装python。windows安装Python3，一直提示各种错误，但是python27可以。

#### powerline-fonts
若需要使状态栏的箭头有特殊的效果，需要安装powerline-fonts的字体。linux下安装方式如下：
```shell
cd ~/.fonts
git clone https://github.com/Lokaltog/powerline-fonts
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
# Merge the contents of 10-powerline-symbols.conf to ~/.fonts.conf
fc-cache -vf ~/.fonts
```
windows下，则直接将https://github.com/Lokaltog/powerline-fonts 下的字体安装下即可。

若无法安装或是不想安装字体，而又想要这些特殊符号，可以使用以下方法，当然样式没有正宗的好看。
在配置文件中找到以下变量，将使值改为0：
```vim
let g:airline_powerline_fonts = 0
```

###安装


#### windows
将目录下的vimrc.vim复制到Vim根目录下，重命名为_vimrc，windows7及之后的版本，
可以使用mklink创建一个链接到vimrc.vim。
```shell
mklink  _vimrc e:\xxx\VimIDE\vimrc.vim

cd vimfiles/bundle/
git clone https://github.com/gmarik/Vundle.vim
vim +PluginIntall
```


#### linux
将vimrc.vim复制到~/下，重命名为.vimrc。或是使用ln命令做一个符号链接到vimrc.vim文件。
```shell
ln -s ~/project/VimIDE/vimrc.vim ~/.vimrc

cd ~/.vim/bundle/
git clone https://github.com/gmarik/Vundle.vim
vim +PluginIntall
```

#### snippets
在vimruntime下，windows为vim/vimfiles；linux下为~/.vim/创建一个硬链接到ultisnippets。
硬链接的创建方式参照上面的代码。

