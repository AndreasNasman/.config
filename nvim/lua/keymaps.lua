local function copy_absolute_file_path()
    vim.fn.setreg('+', vim.fn.expand('%:p'))
end
local function copy_relative_file_path()
    vim.fn.setreg('+', vim.fn.expand('%:~:.'))
end

local function sync_to_system_clipboard()
    vim.fn.setreg('+', vim.fn.getreg('"'))
end

vim.keymap.set('', '<leader>D', '"_d$', { desc = '[D]elete to the black hole register' })
vim.keymap.set('', '<leader>d', '"_d', { desc = '[d]elete to the black hole register' })
vim.keymap.set('', '<leader>Y', '"+y$', { desc = '[Y]ank to the system clipboard' })
vim.keymap.set('', '<leader>y', '"+y', { desc = '[y]ank to the system clipboard' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = '[E]scape search highlighting' })
vim.keymap.set('n', '<leader>+', sync_to_system_clipboard, { desc = 'System clipboard [+] sync' })
vim.keymap.set('n', '<leader>g', '<cmd>Neogit<CR>', { desc = 'Open Neo[G]it' })
vim.keymap.set('n', '<leader>pa', copy_absolute_file_path, { desc = '[P]ath [A]bsolute copy' })
vim.keymap.set('n', '<leader>pr', copy_relative_file_path, { desc = '[P]ath [R]elative copy' })
vim.keymap.set('n', '[q', '<cmd>cprevious<CR>', { desc = 'Previous [Q]uickfix list item' })
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Next [Q]uickfix list item' })

vim.keymap.set('v', '.', ':normal .<cr>', { desc = 'Repeat [.] the last change' })
vim.keymap.set('v', '<leader>p', '"_c<C-r>"<esc>', { desc = '[P]aste to the black hole register' })
