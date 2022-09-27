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


### 依赖的软件


#### git、mercurial

- vim-fugitive：依赖 git 才起作用；
- vim-go：中的`:GoInstallBinaries`命令依赖`go get`，而`go get`依赖 git 和 mercurial；


#### python

UltiSnips 依赖 Python2 或是 Python3，若 vim 编译时是以 python/dyn 形式编译的，
则需要另外安装 python。windows 安装 Python3，一直提示各种错误，但是 python2.7 可以。


#### ctags

majutsushi/tagbar 插件依赖 ctags 来解析。可以从以下地址下载：
[ctags](https://ctags.io/)


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

先安装好插件管理工具 plug，然后然将 vimrc.vim 复制到 ~/.vimrc 下。再执行 `:PlugInstall` 即可。

```url
https://github.com/junegunn/vim-plug
```


### 插件

插件具体功能可直接参考 vimrc.vim 中的说明，部分插件示意图：
![screenshot-plugins](https://raw.github.com/caixw/VimIDE/master/images/screenshot_plugins.png)


### 版权

本项目采用 [MIT](https://opensource.org/licenses/MIT) 开源授权许可证，完整的授权说明可在 [LICENSE](LICENSE) 文件中找到。
