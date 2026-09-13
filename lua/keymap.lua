-- SPDX-FileCopyrightText: 2026 caixw
--
-- SPDX-License-Identifier: MIT

vim.keymap.set("n","<space>","za",{noremap = true, silent = true}) -- 折叠从 za 改为 space
vim.keymap.set("n", "<f1>", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<f4>", "<cmd>SymbolsOutline<cr>")

-- 以下的 <d> 绑定了 macOS 的 command 键，每个 gui 客户端的定义可能不一样。
-- neovide，neovim-qt 可用，其它的未试。

-- 允许 cmd+c,cmd+v
vim.g.neovide_input_use_logo = 1
vim.keymap.set('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.keymap.set('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.keymap.set('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.keymap.set('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.keymap.set('n', '<C-8>', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = '下一个错误'})

-- 按 cmd+number 切换
local bufferline = require("bufferline")
for i = 1, 9 do
	vim.keymap.set('n', '<D-' .. i .. '>', function() bufferline.go_to_buffer(i, true) end)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufNumber = ev.buf -- 获取当前缓冲区的 ID

    -- 定义一个辅助函数，简化快捷键设置
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufNumber, desc = desc })
    end

    -- 常用 LSP 快捷键 (可根据需要修改)
    map('n', 'gd', vim.lsp.buf.definition, '跳转到定义')
    map('n', 'gD', vim.lsp.buf.declaration, '跳转到声明')
    map('n', 'gi', vim.lsp.buf.implementation, '跳转到实现')
    map('n', 'gr', vim.lsp.buf.references, '查找引用')
    map('n', '<C-k>', vim.lsp.buf.hover, '显示悬浮文档')
    map('n', '<C-a>', vim.lsp.buf.code_action, '操作菜单')
    map('n', '<leader>rn', vim.lsp.buf.rename, '重命名符号')
    map('n', '<leader>ca', vim.lsp.buf.code_action, '代码操作')
    map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, '格式化代码')
    map('n', '<f2>', function() vim.lsp.buf.rename() end, '重命名符号')
  end,
})


-- cmd+p 打开文件搜索
vim.keymap.set("n", "<D-p>", "<cmd>:Telescope find_files<cr>", { noremap = true, silent = true})
vim.keymap.set("n", "<D-o>", "<cmd>:Telescope lsp_document_symbols<cr>", { noremap = true, silent = true})

-- cmd+w / cmd+s
vim.keymap.set("n", "<D-w>", "<cmd>:bd<cr>", { noremap = true, silent = true})
vim.keymap.set("n", "<D-s>", "<cmd>:w<cr>", { noremap = true, silent = true})

