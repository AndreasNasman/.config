local function add_move_with_count_to_jumplist(direction)
    return function()
        if vim.v.count == 0 then
            return direction
        end

        return 'm`' .. vim.v.count .. direction
    end
end

local function copy_file_path(pattern)
    local file_path = vim.fn.expand(pattern)
    vim.fn.setreg('"', file_path)
    vim.fn.setreg('+', file_path)
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

local function toggle_neogit()
    local neogit_window = nil

    for _, window in ipairs(vim.api.nvim_list_wins()) do
        local buffer = vim.api.nvim_win_get_buf(window)
        local filetype = vim.bo[buffer].filetype
        if filetype == 'NeogitStatus' then
            neogit_window = window
            break
        end
    end

    if not neogit_window then
        vim.cmd('Neogit')
    elseif vim.api.nvim_get_current_win() == neogit_window then
        vim.api.nvim_win_close(neogit_window, false)
    else
        vim.api.nvim_set_current_win(neogit_window)
    end
end

--stylua: ignore start
vim.keymap.set('', '<leader>D', '"_d$', { desc = '[D]elete to the black hole register' })
vim.keymap.set('', '<leader>d', '"_d', { desc = '[d]elete to the black hole register' })
vim.keymap.set('', '<leader>Y', '"+y$', { desc = '[Y]ank to the system clipboard' })
vim.keymap.set('', '<leader>y', '"+y', { desc = '[y]ank to the system clipboard' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Focus window to the left [h]' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Focus window below [j]' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Focus window above [k]' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Focus window to the right [l]' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = '[E]scape search highlighting' })
vim.keymap.set('n', '<leader>+', sync_to_system_clipboard, { desc = 'System clipboard [+] sync' })
vim.keymap.set('n', '<leader>g', toggle_neogit, { desc = 'Open Neo[G]it' })
vim.keymap.set('n', '<leader>pa', function() copy_file_path('%:p') end, { desc = '[P]ath [A]bsolute copy' })
vim.keymap.set('n', '<leader>pf', function() copy_file_path('%:t') end, { desc = '[P]ath [F]ile name copy' })
vim.keymap.set('n', '<leader>pr', function() copy_file_path('%:~:.') end, { desc = '[P]ath [R]elative copy' })
vim.keymap.set('n', '<leader>tc', toggle_colorcolumn, { desc = '[T]oggle [C]olorcolumn' })
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle [U]ndotree' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Make all [W]indows equal [=] size' })
vim.keymap.set('n', '<leader>wf', '<C-w>_<C-w>|', { desc = '[W]indow [F]ullscreen' })
vim.keymap.set('n', '<leader>wh', '<cmd>leftabove vsplit<CR>', { desc = '[W]indow split to the left [h]' })
vim.keymap.set('n', '<leader>wj', '<cmd>belowright split<CR>', { desc = '[W]indow split below [j]' })
vim.keymap.set('n', '<leader>wk', '<cmd>aboveleft split<CR>', { desc = '[W]indow split above [k]' })
vim.keymap.set('n', '<leader>wl', '<cmd>rightbelow vsplit<CR>', { desc = '[W]indow split to the right [l]' })
vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = 'Keep the current [W]indow open [O]nly' })
vim.keymap.set('n', '<S-h>', '<cmd>tabprevious<CR>', { desc = 'Go to previous tab' })
vim.keymap.set('n', '<S-l>', '<cmd>tabnext<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', '<tab>c', '<cmd>tabclose<CR>', { desc = '[T]ab [C]lose' })
vim.keymap.set('n', '<tab>n', '<cmd>tabnew<CR>', { desc = '[T]ab [N]ew' })
vim.keymap.set('n', '[q', '<cmd>cprevious<CR>', { desc = 'Previous [Q]uickfix list item' })
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Next [Q]uickfix list item' })
vim.keymap.set('n', 'j', add_move_with_count_to_jumplist('j'), { desc = 'Move down [j] with a count and add to the jumplist.', expr = true })
vim.keymap.set('n', 'k', add_move_with_count_to_jumplist('k'), { desc = 'Move up [k] with a count and add to the jumplist.', expr = true })

vim.keymap.set('v', '.', ':normal .<cr>', { desc = 'Repeat [.] the last change' })
vim.keymap.set('v', '<leader>p', '"_c<C-r>"<esc>', { desc = '[P]aste to the black hole register' })
--stylua: ignore end
