-- SPDX-FileCopyrightText: 2026 caixw
--
-- SPDX-License-Identifier: MIT

-- NOTE: 终端下部分快捷键可能会与终端本身的快捷键存在冲突。

require('options')
require('lsp')
require('plugin')
require('keymap')

-- neovide 限定
if vim.g.neovide then
	vim.g.neovide_scroll_animation_length = 0
	vim.g.neovide_cursor_animation_length = 0
end
