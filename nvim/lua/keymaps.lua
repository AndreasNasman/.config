-- stylua: ignore start
vim.keymap.set('', '<leader>D', '"_d$', { desc = 'Delete (D) ("_)' })
vim.keymap.set('', '<leader>d', '"_d', { desc = 'Delete (d) ("_)' })
vim.keymap.set('', '<leader>Y', '"+y$', { desc = 'Copy (Y) ("+)' })
vim.keymap.set('', '<leader>y', '"+y', { desc = 'Copy (y) ("+)' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Stop search highlighting' })
vim.keymap.set('n', '<leader>+', function() vim.fn.setreg('+', vim.fn.getreg('"')) end, { desc = '"" => "+' })
vim.keymap.set('n', '<leader>pa', function() vim.fn.setreg('+', vim.fn.expand('%:p')) end, { desc = 'Copy file path (absolute) ("+)' })
vim.keymap.set('n', '<leader>pr', function() vim.fn.setreg('+', vim.fn.expand('%:~:.')) end, { desc = 'Copy file path (relative) ("+)' })

vim.keymap.set('v', '.', ':normal .<cr>', { desc = 'Repeat last change' })
vim.keymap.set('v', '<leader>p', '"_c<C-r>"<esc>', { desc = 'Paste ("_)' })
