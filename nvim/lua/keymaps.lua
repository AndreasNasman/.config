local function add_move_with_count_to_jumplist(direction)
    return function()
        if vim.v.count == 0 then
            return direction
        end

        return 'm`' .. vim.v.count .. direction
    end
end

local function copy_absolute_file_path()
    vim.fn.setreg('+', vim.fn.expand('%:p'))
end

local function copy_relative_file_path()
    vim.fn.setreg('+', vim.fn.expand('%:~:.'))
end

local function sync_to_system_clipboard()
    vim.fn.setreg('+', vim.fn.getreg('"'))
end

local colorcolumn_active = false
local function toggle_colorcolumn()
    if colorcolumn_active then
        vim.opt.colorcolumn = ''
        colorcolumn_active = false
    else
        vim.opt.colorcolumn = '80'
        colorcolumn_active = true
    end
end

--stylua: ignore start
vim.keymap.set('', '<leader>D', '"_d$', { desc = '[D]elete to the black hole register' })
vim.keymap.set('', '<leader>d', '"_d', { desc = '[d]elete to the black hole register' })
vim.keymap.set('', '<leader>Y', '"+y$', { desc = '[Y]ank to the system clipboard' })
vim.keymap.set('', '<leader>y', '"+y', { desc = '[y]ank to the system clipboard' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = '[E]scape search highlighting' })
vim.keymap.set('n', '<leader>+', sync_to_system_clipboard, { desc = 'System clipboard [+] sync' })
vim.keymap.set('n', '<leader><tab>c', '<cmd>tabclose<CR>', { desc = '[T]ab [C]lose' })
vim.keymap.set('n', '<leader><tab>n', '<cmd>tabnew<CR>', { desc = '[T]ab [N]ew' })
vim.keymap.set('n', '<leader>g', '<cmd>Neogit<CR>', { desc = 'Open Neo[G]it' })
vim.keymap.set('n', '<leader>pa', copy_absolute_file_path, { desc = '[P]ath [A]bsolute copy' })
vim.keymap.set('n', '<leader>pr', copy_relative_file_path, { desc = '[P]ath [R]elative copy' })
vim.keymap.set('n', '<leader>tc', toggle_colorcolumn, { desc = '[T]oggle [C]olorcolumn' })
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle [U]ndotree' })
vim.keymap.set('n', '<s-tab>', '<cmd>tabprevious<CR>', { desc = 'Go to previous [T]ab' })
vim.keymap.set('n', '<tab>', '<cmd>tabnext<CR>', { desc = 'Go to next [T]ab' })
vim.keymap.set('n', '[q', '<cmd>cprevious<CR>', { desc = 'Previous [Q]uickfix list item' })
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Next [Q]uickfix list item' })
vim.keymap.set('n', 'j', add_move_with_count_to_jumplist('j'), { desc = 'Move down [j] with a count and add to the jumplist.', expr = true })
vim.keymap.set('n', 'k', add_move_with_count_to_jumplist('k'), { desc = 'Move up [k] with a count and add to the jumplist.', expr = true })

vim.keymap.set('v', '.', ':normal .<cr>', { desc = 'Repeat [.] the last change' })
vim.keymap.set('v', '<leader>p', '"_c<C-r>"<esc>', { desc = '[P]aste to the black hole register' })
--stylua: ignore end
