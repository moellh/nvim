-- navigate quickfix list
vim.keymap.set('n', '<leader>qn', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<leader>qp', '<cmd>cprev<CR>zz')

-- navigate location list
vim.keymap.set('n', '<leader>wn', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>wp', '<cmd>lprev<CR>zz')

return {}
