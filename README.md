VimIDE
======

自用的一个vim配置文件，针对gvim，不保证vim下能全部正常使用。适用于`Go`与`PHP`。

![screenshot](https://raw.github.com/caixw/VimIDE/master/images/screenshot.png)



### 依赖的软件

gvim只能确保7.4版本可以正常使用所有功能，其它版本未测试！


#### git、mercurial
- Vundle：依赖git从服务器上下载插件；
- vim-fugitive：也依赖git才起作用；
- vim-go：中依赖的软件可以运行`:GoInstallBinaries`命令检测和安装需要用到的软件。
该命令会用到git或是mercurial软件；


#### python
UltiSnips依赖Python2或是Python3，若vim编译时是以python/dyn形式编译的，
则需要另外安装python。windows安装Python3，一直提示各种错误，但是python27可以。


#### ctags
majutsushi/tagbar插件依赖ctags来解析。可以从以下地址下载：
[ctags](http://ctags.sourceforge.net/)


#### YCM
YCM插件需要编译之后才可以用，所以可能还需要安装一系统的编译工具：gcc、cmake等。
具体安装步骤可参考：[YCM安装](https://github.com/Valloric/YouCompleteMe#installation)。
windows比较麻烦，下如果折腾不出来就算了。


#### powerline-fonts
airline需要使用到这些字体，用于美化状态栏。

linux下安装方式如下：
```shell
cd ~/.fonts
git clone https://github.com/Lokaltog/powerline-fonts
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
# Merge the contents of 10-powerline-symbols.conf to ~/.fonts.conf
fc-cache -vf ~/.fonts
```

windows下，则直接将https://github.com/Lokaltog/powerline-fonts下的字体依次安装下即可。

安装完之后，在配置文件(vimrc.vim)中的到以下变量，将其值设置为1，才能起作用：
```vim
let g:airline_powerline_fonts = 1
```

### 安装


#### windows
```shell
# 切换到vim安装根目录
cd x:\xxx\Vim

# 将配置文件链接到vimrc.vim，若已经存在_vimrc可以先删除
mklink _vimrc x:\xxx\VimIDE\vimrc.vim

# 若不存在bundle，则手动创建。
cd vimfiles/bundle/
mklink ultisnippets x:\xxx\VimIDE\ultisnippets

# 安装Vundle
git clone https://github.com/gmarik/Vundle.vim
```
在gvim中执行以下命令安装其它插件：
```vim
:PluginInstall
```

windows7之前的版本没有`mklink`命令，要以直接复制需要的文件到指定目录。


#### linux
```shell
unlink  ~/.vimrc
ln -s ~/project/VimIDE/vimrc.vim  ~/.vimrc

mkdir ~/.vim/bundle/
cd ~/.vim/bundle/
ln -s ~/project/VimIDE/ultisnippets  ./ultisnippets

git clone https://github.com/gmarik/Vundle.vim
vim +PluginIntall
```
