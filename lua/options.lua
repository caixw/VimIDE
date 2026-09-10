-- SPDX-FileCopyrightText: 2026 caixw
--
-- SPDX-License-Identifier: MIT

vim.g.encoding = "utf-8"
vim.o.syntax = "enable"
vim.o.autochdir = true -- 自动切换目录
vim.o.fileformats = unix
vim.o.laststatus = 3 -- 全局状态栏

vim.o.showmatch = true
vim.o.showmode = true -- 左下角显示当前的模式
vim.o.showcmd = true -- 显示当前输入的命令
vim.o.mousemodel = popup -- 右键点击时，弹出菜单
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus' -- use system clipboard

-- vim.o.relativenumber = true -- 显示相对行号
vim.o.number = true -- 显示行号
vim.o.cursorline = true -- 高亮所在行
vim.o.wrap = true -- 自动换行
vim.o.ruler = true -- 显示光标位置

-- 搜索
vim.o.incsearch = true -- 边输入边搜索
vim.o.hlsearch = true -- 开启搜索匹配高亮
vim.o.smartcase = true -- 搜索时自行判断是否需要忽略大小写

-- tab 相关设置
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = false
vim.bo.expandtab = false
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- 使用 jk 移动光标时，上下方保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

vim.o.history = 1000
vim.o.undofile = true

vim.o.list = true
vim.o.listchars = "tab:» ,lead:·,trail:·,extends:…"

-- gui 限定
vim.o.guifont = "Monofur Nerd Font Mono:h15"

-- 代码折叠，可以有以下值：
-- manual
-- indent
-- marker
-- expr
-- syntax
-- diff
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.o.winborder = "rounded"

-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true