---------------------------------------------------
-- NeoVIM 配置
--
-- Author:	  caixw <https://github.com/caixw>
-- Version:   0.7.0.20231011
-- Licence:   MIT
--
-- NOTE: macOS 终端下部分快捷键可能会不可用。
---------------------------------------------------

vim.g.encoding = "utf-8"
vim.o.termencoding = "utf-8"
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


---------------- 开始插件设置

local bufferline

local floatBorder = 'single' -- 浮动窗口的边框

-- 加载 lazy 插件管理
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		-- LSP
		-- https://github.com/neovim/nvim-lspconfig
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").gopls.setup({
				on_attach = function(client, buffer)
					-- 几种需要边框的
					require('lspconfig.ui.windows').default_options.border = floatBorder
					vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border = floatBorder})
					vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = floatBorder})
					vim.diagnostic.config({float = {border = floatBorder}})

					-- 在插入模式可以按 <c-x><c-o> 触发补全
					-- vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

					local opts = { noremap=true, silent=true }
					vim.api.nvim_buf_set_keymap(buffer, "n", "<c-k>", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.api.nvim_buf_set_keymap(buffer, "n", "<c-a>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
					vim.api.nvim_buf_set_keymap(buffer, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.api.nvim_buf_set_keymap(buffer, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.api.nvim_buf_set_keymap(buffer, 'n', '<c-8>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

					-- imports
					vim.api.nvim_create_autocmd("BufWritePre", {
						pattern = "*.go",
						callback = function()
							local params = vim.lsp.util.make_range_params()
							params.context = {only = {"source.organizeImports"}}
							-- 可以有第四个参数，默认为 1000 ms，如果有多次写入可以添加此值，
							-- 比如：vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
							local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
							for cid, res in pairs(result or {}) do
								for _, r in pairs(res.result or {}) do
									if r.edit then
										local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-8"
										vim.lsp.util.apply_workspace_edit(r.edit, enc)
									end
								end
							end
							vim.lsp.buf.format({async = false})
						end -- end callback
					})
				end, -- end on_attach

				settings = {
					gopls = {
						gofumpt = true,
						staticcheck = true,
						analyses = {
							unusedparams = true
						}
					}
				},
			})
		end -- end config
	},
	{
		-- 智能感知
		-- https://github.com/hrsh7th/nvim-cmp
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
		},
		config = function()
			vim.opt.completeopt = { "menu", "menuone", "noselect" }
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},

				mapping = cmp.mapping.preset.insert({
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-y>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
				}),

				window = {
					documentation = cmp.config.window.bordered()
				},

				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'nvim_path' },
					{ name = 'vsnip' },
				})
			}) -- end setup

			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			require('lspconfig')['go'].setup {
				capabilities = capabilities
			}
		end
	},
	{
		-- buffer 栏
		-- https://github.com/akinsho/bufferline.nvim
		'akinsho/bufferline.nvim', version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			bufferline = require("bufferline")
			bufferline.setup({
				options = {
					offsets = {{
						filetype = "NvimTree",
						text = "文件夹",
						separator = true,
						text_align = "left",
					}},
					diagnostics = "nvim_lsp",
					numbers = "ordinal",
				}
			})
		end
	},
	{
		-- 文件浏览
		-- https://github.com/nvim-tree/nvim-tree.lua
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({
				actions = {
					change_dir = {
						enable = true,
						global = true
					},
					open_file = {
						resize_window = true
					}
				},
				renderer = {
					indent_markers = {
						enable = true
					}
				},
				view = {
					width = 40
				}
			})
		end
	},
	{
		-- 状态栏
		-- https://github.com/nvim-lualine/lualine.nvim
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local modes = { -- 几种模式对应的中文
				NORMAL = "标准",
				VISUAL = "可视",
				INSERT = "插入",
				SELECT = "选择",
				COMMAND = "命令行",
				REPLACE = "替换",
			}

			local mode_name = function(mode) -- 根据模式返回中文名称
				if modes[mode] ~= nil then
					return modes[mode]
				end
				return mode
			end

			require("lualine").setup({
				sections = {
					lualine_a = {{'mode',fmt = mode_name }},
				},
			})
		end
	},
	{
		--https://github.com/sindrets/diffview.nvim
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup()
		end
	},
	{
		-- 文档结构
		-- https://github.com/simrat39/symbols-outline.nvim
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({
				width = 20
			})
		end
	},
	{
		-- git 状态
		-- https://github.com/lewis6991/gitsigns.nvim
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end
	},
	{
		-- https://github.com/goolord/alpha-nvim
		"goolord/alpha-nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end
	},
	{
		-- https://github.com/nvim-telescope/telescope.nvim
		"nvim-telescope/telescope.nvim", branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		-- https://github.com/dstein64/nvim-scrollview
		"dstein64/nvim-scrollview",
		config = function()
			require("scrollview").setup()
		end
	},
	{
		-- https://github.com/folke/todo-comments.nvim
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" }
	},

	-- 以下开始为主题内容

	{
		-- colors
		-- https://github.com/marko-cerovac/material.nvim
		"marko-cerovac/material.nvim",
	},
}, {
	ui = {
		border = floatBorder
	}
})

-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
vim.g.material_style = "Oceanic"
vim.cmd.colorscheme "material"
vim.keymap.set("n","<space>","za",{noremap = true, silent = true}) -- 折叠从 za 改为 space

vim.keymap.set("n", "<f1>", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<f2>", "<cmd>SymbolsOutline<cr>")

-- 以下的 <d> 绑定了 macOS 的 command 键，每个 gui 客户端的定义可能不一样。
-- neovide，neovim-qt 可用，其它的未试。

-- 允许 cmd+c,cmd+v
vim.g.neovide_input_use_logo = 1
vim.keymap.set('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.keymap.set('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.keymap.set('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.keymap.set('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

-- 按 cmd+number 切换
for i = 1, 9 do
	vim.keymap.set('n', '<D-' .. i .. '>', function() bufferline.go_to_buffer(i, true) end)
end

-- cmd+p 打开文件搜索
vim.keymap.set("n", "<D-p>", "<cmd>:Telescope find_files<cr>", { noremap = true, silent = true})
vim.keymap.set("n", "<D-o>", "<cmd>:Telescope lsp_document_symbols<cr>", { noremap = true, silent = true})

-- cmd+w / cmd+s
vim.keymap.set("n", "<D-w>", "<cmd>:bd<cr>", { noremap = true, silent = true})
vim.keymap.set("n", "<D-s>", "<cmd>:w<cr>", { noremap = true, silent = true})

vim.keymap.set("n", "<f2>", "<cmd>:lua vim.lsp.buf.rename()<cr>", { noremap = true, silent = true})


-- neovide 限定
if vim.g.neovide then
	vim.g.neovide_scroll_animation_length = 0
	vim.g.neovide_cursor_animation_length = 0
end
