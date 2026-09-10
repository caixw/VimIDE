-- SPDX-FileCopyrightText: 2026 caixw
--
-- SPDX-License-Identifier: MIT

vim.lsp.config('gopls', {
	cmd = { 'gopls' },
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
	root_markers = { 'go.work', 'go.mod', '.git' },

	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			completeUnimported = true,      -- 自动补全未导入的包
			usePlaceholders = true,          -- 函数参数使用占位符
			analyses = {
				unusedparams = true,           -- 提示未使用的参数
			},
		},
	},
})
vim.lsp.enable('gopls')