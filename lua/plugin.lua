-- SPDX-FileCopyrightText: 2026 caixw
--
-- SPDX-License-Identifier: MIT

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
	-- 智能感知
	-- https://github.com/saghen/blink.cmp
	{
		'saghen/blink.cmp',
		dependencies = {
			'saghen/blink.lib',
			-- optional: provides snippets for the snippet source
			'rafamadriz/friendly-snippets',
		},
		build = function()
			-- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
			-- you can use `gb` in `:Lazy` to rebuild the plugin as needed
			require('blink.cmp').build():pwait()
		end,

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = 'default' },

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },

			-- (Default) list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
		},
	}
	,
	-- buffer 栏
	-- https://github.com/akinsho/bufferline.nvim
	{
		'akinsho/bufferline.nvim', version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("bufferline").setup({
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

	-- 文件浏览
	-- https://github.com/nvim-tree/nvim-tree.lua
	{
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

	-- 状态栏
	-- https://github.com/nvim-lualine/lualine.nvim
	{
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

	--https://github.com/sindrets/diffview.nvim
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup()
		end
	},

	-- 文档结构
	-- https://github.com/simrat39/symbols-outline.nvim
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({
				width = 20
			})
		end
	},

	-- git 状态
	-- https://github.com/lewis6991/gitsigns.nvim
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end
	},

	-- https://github.com/goolord/alpha-nvim
	{
		"goolord/alpha-nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end
	},

	-- https://github.com/nvim-telescope/telescope.nvim
	{
		"nvim-telescope/telescope.nvim", branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- https://github.com/dstein64/nvim-scrollview
	{
		"dstein64/nvim-scrollview",
		config = function()
			require("scrollview").setup()
		end
	},

	-- https://github.com/folke/todo-comments.nvim
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" }
	},

	-- 以下开始为主题内容

	-- colors
	-- https://github.com/marko-cerovac/material.nvim
	{
		"marko-cerovac/material.nvim",
	},
})

vim.g.material_style = "Oceanic"
vim.cmd.colorscheme "material"