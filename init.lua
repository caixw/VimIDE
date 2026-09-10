---------------------------------------------------
-- NeoVIM 配置
--
-- Author:    caixw <https://github.com/caixw>
-- Version:   0.9.0.20260910
-- Licence:   MIT
--
-- NOTE: macOS 终端下部分快捷键可能会不可用。
---------------------------------------------------

require('options')
require('lsp')
require('plugin')
require('keymap')

-- neovide 限定
if vim.g.neovide then
	vim.g.neovide_scroll_animation_length = 0
	vim.g.neovide_cursor_animation_length = 0
end
