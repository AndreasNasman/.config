---@param direction string
local function add_move_with_count_to_jumplist(direction)
    return function()
        if vim.v.count == 0 then
            return direction
        end

        return 'm`' .. vim.v.count .. direction
    end
end

---@param pattern string
local function copy_file_path(pattern)
    local file_path = vim.fn.expand(pattern)
    vim.fn.setreg('"', file_path)
    vim.fn.setreg('+', file_path)
    vim.notify('File path copied to the clipboard: ' .. file_path, vim.log.levels.INFO)
end

local function sync_to_system_clipboard()
    vim.fn.setreg('+', vim.fn.getreg('"'))
end

local colorcolumn_values = { '', '120', '80' }
local current_colorcolumn_index = 1
local function toggle_colorcolumn()
    current_colorcolumn_index = current_colorcolumn_index % #colorcolumn_values + 1
    vim.opt.colorcolumn = colorcolumn_values[current_colorcolumn_index]
end

---@param command string
local function toggle_command(command)
    local buffer = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[buffer].filetype
    if filetype == string.lower(command) then
        vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
    else
        vim.cmd(command)
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

---@param plugin_name string
---@param args table|nil
local function toggle_plugin(plugin_name, args)
    args = args or {}
    local plugin = require(plugin_name)

    local buffer = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[buffer].filetype
    if filetype == plugin_name:gsub('%.', '') then
        plugin.close()
    else
        plugin.open(unpack(args))
    end
end

--stylua: ignore start
vim.keymap.set({ 'n', 'x' }, '<Leader>d', '"_d', { desc = '[d]elete to the black hole register' })
vim.keymap.set({ 'n', 'x' }, '<Leader>Y', '"+y$', { desc = '[Y]ank to the system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y', { desc = '[y]ank to the system clipboard' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Focus window to the left [h]' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Focus window below [j]' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Focus window above [k]' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Focus window to the right [l]' })
vim.keymap.set('n', '<D-d>', vim.diagnostic.open_float, { desc = 'Show [D]iagnostic' })
vim.keymap.set('n', '<D-h>', '<Cmd>tabprevious<CR>', { desc = 'Go to the previous [h] tab' })
vim.keymap.set('n', '<D-l>', '<Cmd>tabnext<CR>', { desc = 'Go to the next [l] tab' })
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', { desc = '[E]scape search highlighting' })
vim.keymap.set('n', '<Leader>+', sync_to_system_clipboard, { desc = 'Sync system clipboard [+]' })
vim.keymap.set('n', '<Leader>fa', function() copy_file_path('%:p') end, { desc = '[F]ile path, [A]bsolute copy' })
vim.keymap.set('n', '<Leader>fn', function() copy_file_path('%:t') end, { desc = '[F]ile [N]ame copy' })
vim.keymap.set('n', '<Leader>fr', function() copy_file_path('%:~:.') end, { desc = '[F]ile path, [R]elative copy' })
vim.keymap.set('n', '<Leader>g', toggle_neogit, { desc = 'Toggle Neo[G]it' })
vim.keymap.set('n', '<Leader>li', function() toggle_command('LspInfo') end, { desc = 'Toggle [L]sp[I]nfo' })
vim.keymap.set('n', '<Leader>mf', function() toggle_plugin('mini.files', { vim.api.nvim_buf_get_name(0) }) end, { desc = 'Toggle Mini[F]iles' })
vim.keymap.set('n', '<Leader>o', function () toggle_plugin('oil') end, { desc = 'Toggle [O]il' })
vim.keymap.set('n', '<Leader>pl', function() toggle_command('Lazy') end, { desc = 'Toggle [P]lugin [L]azy' })
vim.keymap.set('n', '<Leader>pm', function() toggle_command('Mason') end, { desc = 'Toggle [P]lugin [M]ason' })
vim.keymap.set('n', '<Leader>tc', toggle_colorcolumn, { desc = '[T]oggle [C]olorcolumn' })
vim.keymap.set('n', '<Leader>u', '<Cmd>UndotreeToggle<CR>', { desc = 'Toggle [U]ndotree' })
vim.keymap.set('n', '<Leader>w', '<C-w>', { desc = 'Control [W]indows with the <Leader> key' })
vim.keymap.set('n', '<Leader>wf', '<C-w>_<C-w>|', { desc = '[W]indows, [F]ullscreen' })
vim.keymap.set('n', '<Leader>wh', '<Cmd>leftabove vsplit<CR>', { desc = '[W]indows, split to the left [h]' })
vim.keymap.set('n', '<Leader>wj', '<Cmd>belowright split<CR>', { desc = '[W]indows, split below [j]' })
vim.keymap.set('n', '<Leader>wk', '<Cmd>aboveleft split<CR>', { desc = '[W]indows, split above [k]' })
vim.keymap.set('n', '<Leader>wl', '<Cmd>rightbelow vsplit<CR>', { desc = '[W]indows, split to the right [l]' })
vim.keymap.set('n', '<M-c>', '<Cmd>tabclose<CR>', { desc = 'Tab, [C]lose' })
vim.keymap.set('n', '<M-n>', '<Cmd>tabnew<CR>', { desc = 'Tab, [N]ew' })
vim.keymap.set('n', '[q', '<Cmd>cprevious<CR>', { desc = 'Previous [Q]uickfix list item' })
vim.keymap.set('n', ']q', '<Cmd>cnext<CR>', { desc = 'Next [Q]uickfix list item' })
vim.keymap.set('n', 'j', add_move_with_count_to_jumplist('j'), { desc = 'Move down [j] with a count and add to the jumplist', expr = true })
vim.keymap.set('n', 'k', add_move_with_count_to_jumplist('k'), { desc = 'Move up [k] with a count and add to the jumplist', expr = true })

vim.keymap.set('x', '.', ':normal .<CR>', { desc = 'Repeat [.] the last change' })
vim.keymap.set('x', '<Leader>p', '"_c<C-r>"<esc>', { desc = '[P]aste to the black hole register' })
--stylua: ignore end
