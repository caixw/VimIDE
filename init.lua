---------------------------------------------------
-- NeoVIM 配置
--
-- Author:    caixw <https://github.com/caixw>
-- Version:   0.5.0.20230828
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
-- tab键转换为 4 个空格
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = false
vim.bo.expandtab = false
vim.o.shiftwidth = 4 -- << >> 缩进时移动的长度
vim.bo.shiftwidth = 4
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- 使用jk移动光标时，上下方保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

vim.o.history = 1000
vim.o.list = true
vim.o.undofile = true

-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true


---------------- 开始插件设置

-- 几种模式对应的中文
local modes = {
	NORMAL = "标准",
	VISUAL = "可视",
	INSERT = "插入",
	SELECT = "选择",
	COMMAND = "命令行",
	REPLACE = "替换",
}

-- 根据模式返回中文名称
function mode_name(mode)
	if modes[mode] ~= nil then
		return modes[mode]
	end
	return mode
end

local bufferline

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

-- 其它插件

require("lazy").setup({
	{
		-- LSP
		-- https://github.com/neovim/nvim-lspconfig
		"neovim/nvim-lspconfig",
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			require("lspconfig").gopls.setup({
				on_attach = function(client, buffer)
					-- 在插入模式可以按 <c-x><c-o> 触发补全
					vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

					local opts = { noremap=true, silent=true }
					vim.api.nvim_buf_set_keymap(buffer, "n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.api.nvim_buf_set_keymap(buffer, "n", "<c-a>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
					vim.api.nvim_buf_set_keymap(buffer, "n", "<gD>", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.api.nvim_buf_set_keymap(buffer, "n", "<gd>", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.api.nvim_buf_set_keymap(buffer, 'n', '<c-8>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

					-- format on save
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = buffer,
							callback = function()
								vim.lsp.buf.format()
							end,
						})
					end
				end -- end on_attach
			})
		end
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
		-- 高亮缩进
		-- https://github.com/lukas-reineke/indent-blankline.nvim
		-- "lukas-reineke/indent-blankline.nvim",
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
					}
				},
				renderer = {
					indent_markers = {
						enable = true
					}
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
			require("lualine").setup({
				sections = {
					lualine_a = {{'mode',fmt = mode_name }},
				},
			})
		end
	},
	{
		-- 文档结构
		-- https://github.com/simrat39/symbols-outline.nvim
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
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
		-- https://github.com/nvim-telescope/telescope.nvim
		"nvim-telescope/telescope.nvim", branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
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
})

vim.cmd.colorscheme "material"

vim.keymap.set("n", "<f1>", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<f2>", "<cmd>SymbolsOutline<cr>")

-- 以下的 <d> 只有特定的 gui 客户端才有效果。
-- neovide 可用，其它的未试。

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

-- cmd+w / cmd+s
vim.keymap.set("n", "<D-w>", "<cmd>:bd<cr>", { noremap = true, silent = true})
vim.keymap.set("n", "<D-s>", "<cmd>:w<cr>", { noremap = true, silent = true})
