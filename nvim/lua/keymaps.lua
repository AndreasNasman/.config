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
vim.keymap.set('', '<Leader>D', '"_d$', { desc = '[D]elete to the black hole register' })
vim.keymap.set('', '<Leader>d', '"_d', { desc = '[d]elete to the black hole register' })
vim.keymap.set('', '<Leader>Y', '"+y$', { desc = '[Y]ank to the system clipboard' })
vim.keymap.set('', '<Leader>y', '"+y', { desc = '[y]ank to the system clipboard' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Focus window to the left [h]' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Focus window below [j]' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Focus window above [k]' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Focus window to the right [l]' })
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', { desc = '[E]scape search highlighting' })
vim.keymap.set('n', '<Leader>+', sync_to_system_clipboard, { desc = 'System clipboard [+] sync' })
vim.keymap.set('n', '<Leader>g', toggle_neogit, { desc = 'Open Neo[G]it' })
vim.keymap.set('n', '<Leader>pa', function() copy_file_path('%:p') end, { desc = '[P]ath [A]bsolute copy' })
vim.keymap.set('n', '<Leader>pf', function() copy_file_path('%:t') end, { desc = '[P]ath [F]ile name copy' })
vim.keymap.set('n', '<Leader>pr', function() copy_file_path('%:~:.') end, { desc = '[P]ath [R]elative copy' })
vim.keymap.set('n', '<Leader>tc', toggle_colorcolumn, { desc = '[T]oggle [C]olorcolumn' })
vim.keymap.set('n', '<Leader>u', '<Cmd>UndotreeToggle<CR>', { desc = 'Toggle [U]ndotree' })
vim.keymap.set('n', '<Leader>w=', '<C-w>=', { desc = '[W]indows equal [=] size' })
vim.keymap.set('n', '<Leader>wf', '<C-w>_<C-w>|', { desc = '[W]indow [F]ullsCReen' })
vim.keymap.set('n', '<Leader>wh', '<Cmd>leftabove vsplit<CR>', { desc = '[W]indow split to the left [h]' })
vim.keymap.set('n', '<Leader>wj', '<Cmd>belowright split<CR>', { desc = '[W]indow split below [j]' })
vim.keymap.set('n', '<Leader>wk', '<Cmd>aboveleft split<CR>', { desc = '[W]indow split above [k]' })
vim.keymap.set('n', '<Leader>wl', '<Cmd>rightbelow vsplit<CR>', { desc = '[W]indow split to the right [l]' })
vim.keymap.set('n', '<Leader>wo', '<Cmd>only<CR>', { desc = '[W]indow [O]nly' })
vim.keymap.set('n', '<Leader>wq', '<Cmd>quit<CR>', { desc = '[W]indow [Q]uit' })
vim.keymap.set('n', '<S-h>', '<Cmd>tabprevious<CR>', { desc = 'Go to previous Tab' })
vim.keymap.set('n', '<S-l>', '<Cmd>tabnext<CR>', { desc = 'Go to next Tab' })
vim.keymap.set('n', '<Tab>c', '<Cmd>tabclose<CR>', { desc = '[T]ab [C]lose' })
vim.keymap.set('n', '<Tab>n', '<Cmd>tabnew<CR>', { desc = '[T]ab [N]ew' })
vim.keymap.set('n', '[q', '<Cmd>cprevious<CR>', { desc = 'Previous [Q]uickfix list item' })
vim.keymap.set('n', ']q', '<Cmd>cnext<CR>', { desc = 'Next [Q]uickfix list item' })
vim.keymap.set('n', 'j', add_move_with_count_to_jumplist('j'), { desc = 'Move down [j] with a count and add to the jumplist', expr = true })
vim.keymap.set('n', 'k', add_move_with_count_to_jumplist('k'), { desc = 'Move up [k] with a count and add to the jumplist', expr = true })

vim.keymap.set('v', '.', ':normal .<CR>', { desc = 'Repeat [.] the last change' })
vim.keymap.set('v', '<Leader>p', '"_c<C-r>"<esc>', { desc = '[P]aste to the black hole register' })
--stylua: ignore end
