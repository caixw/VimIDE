VimIDE
======

自用的一个 vim 配置文件，适用于`Go`与`PHP`语言环境。

适用版本：
windows/linux 下只通过 Gvim8 的测试。
macOS 下 vim8 或是对应版本的 macvim。

![screenshot](https://raw.github.com/caixw/VimIDE/master/images/screenshot.png)



### 快捷键

自定义的快捷键:

 快捷键        | 对应操作
 ------------- | :---------
 `<F1>`        | 打开类/函数视图(tagbar)
 `<F2>`        | 打开文件浏览窗口(NERDTree)
 `<C-u>`       | 显示自动提示内容，默认为键为`<C-x>`-`<C-o>`
 `<C-i>`       | 产生`PHP`文档



### 依赖的软件


#### git、mercurial
- Vundle：依赖 git 从服务器上下载插件；
- vim-fugitive：也依赖 git 才起作用；
- vim-go：中的`:GoInstallBinaries`命令依赖`go get`，而`go get`依赖 git 和 mercurial；


#### python
UltiSnips 依赖 Python2 或是 Python3，若 vim 编译时是以 python/dyn 形式编译的，
则需要另外安装 python。windows 安装 Python3，一直提示各种错误，但是 python2.7 可以。


#### ctags
majutsushi/tagbar 插件依赖 ctags 来解析。可以从以下地址下载：
[ctags](http://ctags.sourceforge.net/)


#### YCM
YCM 插件需要编译之后才可以用，所以可能还需要安装一系统的编译工具：gcc、cmake 等。
具体安装步骤可参考：[YCM安装](https://github.com/Valloric/YouCompleteMe#installation)。
windows 比较麻烦，如果折腾不出来就算了。

#### vim-go
vim-go 插件依赖一大堆 Go 程序，可以通过运行`:GoInstallBinaries`来自行安装，
前提是你已经正确安装 Go、git 和 mercurial。而且有一部分 Go 程序源代码处在墙外面。


#### powerline-fonts
airline 需要使用到这些字体，用于美化状态栏。

linux/macOS：
```shell
cd ~
git clone github.com:powerline/fonts
cd fonts
./install.sh
```

windows 下，则直接将[powerline-fonts](https://github.com/Lokaltog/powerline-fonts)下的字体依次安装下即可。

安装完之后，在配置文件(vimrc.vim)中的到以下变量，将其值设置为 1，才能起作用：
```vim
let g:airline_powerline_fonts = 1
```



### 安装


#### windows
```shell
# 切换到 vim 安装根目录
cd x:\xxx\Vim

# 将配置文件链接到 vimrc.vim，若已经存在 _vimrc 可以先删除
mklink _vimrc x:\xxx\VimIDE\vimrc.vim

# 若不存在 bundle，则手动创建。
cd vimfiles/bundle/
mklink ultisnippets x:\xxx\VimIDE\ultisnippets

# 安装 Vundle
git clone https://github.com/gmarik/Vundle.vim
```
在 Gvim 中执行`:PluginInstall`命令安装其它插件。

windows7 之前的版本没有`mklink`命令，可以直接复制需要的文件到指定目录。


#### linux
```shell
unlink  ~/.vimrc
ln -s ~/project/VimIDE/vimrc.vim  ~/.vimrc

# 安装 Vundle
mkdir ~/.vim/bundle/
cd ~/.vim/bundle/
git clone https://github.com/gmarik/Vundle.vim

# 链接 ultisnippets 到 rtp
ln -s ~/project/VimIDE/ultisnippets  ./ultisnippets

# 安装所有的插件
vim +PluginIntall
```

#### macOS
```shell
unlink  ~/.vimrc
ln -s ~/project/VimIDE/vimrc.vim  ~/.vimrc

# 安装 Vundle
mkdir ~/.vim/bundle/
cd ~/.vim/bundle/
git clone https://github.com/gmarik/Vundle.vim

# 链接 ultisnippets 到 rtp
cd ~/.vim/
ln -s ~/project/VimIDE/ultisnippets  ./ultisnippets

# 安装所有的插件
vim +PluginIntall

```



### 插件

插件具体功能可直接参考 vimrc.vim 中的说明，部分插件示意图：
![screenshot-plugins](https://raw.github.com/caixw/VimIDE/master/images/screenshot_plugins.png)



### 版权

本项目采用[MIT](https://opensource.org/licenses/MIT)开源授权许可证，完整的授权说明可在[LICENSE](LICENSE)文件中找到。
