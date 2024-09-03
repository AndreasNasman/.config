-- [[ Clipboard ]]
-- System
local function sync_to_system_clipboard()
    vim.fn.setreg('+', vim.fn.getreg('"'))
end

vim.keymap.set('n', '<Leader>+', sync_to_system_clipboard)
vim.keymap.set({ 'n', 'x' }, '<Leader>Y', '"+y$')
vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')

-- Black hole
vim.keymap.set('x', '<Leader>p', '"_c<C-r>"<esc>')
vim.keymap.set({ 'n', 'x' }, '<Leader>d', '"_d')

-- [[ Diagnostics ]]
vim.keymap.set('n', '<D-d>', vim.diagnostic.open_float)

-- [[ File path ]]
---@param pattern string
local function copy_file_path(pattern)
    local file_path = vim.fn.expand(pattern)
    vim.fn.setreg('"', file_path)
    vim.fn.setreg('+', file_path)
    vim.notify('File path copied to the clipboard: ' .. file_path, vim.log.levels.INFO)
end

vim.keymap.set('n', '<Leader>fa', function()
    copy_file_path('%:p')
end)
vim.keymap.set('n', '<Leader>fn', function()
    copy_file_path('%:t')
end)
vim.keymap.set('n', '<Leader>fr', function()
    copy_file_path('%:~:.')
end)

-- [[ Jump list ]]
---@param direction string
local function add_move_with_count_to_jumplist(direction)
    return function()
        if vim.v.count == 0 then
            return direction
        end

        return 'm`' .. vim.v.count .. direction
    end
end

vim.keymap.set('n', 'j', add_move_with_count_to_jumplist('j'), { expr = true })
vim.keymap.set('n', 'k', add_move_with_count_to_jumplist('k'), { expr = true })

-- [[ Quickfix list ]]
vim.keymap.set('n', '[q', '<Cmd>cprevious<CR>')
vim.keymap.set('n', ']q', '<Cmd>cnext<CR>')

-- [[ Tabs ]]
-- Management
vim.keymap.set('n', '<M-c>', '<Cmd>tabclose<CR>')
vim.keymap.set('n', '<M-n>', '<Cmd>tabnew<CR>')

-- Navigation
vim.keymap.set('n', '<D-[>', '<Cmd>tabprevious<CR>')
vim.keymap.set('n', '<D-]>', '<Cmd>tabnext<CR>')

-- [[ Toggles ]]
---@param target string
---@param args table|nil
local function toggle(target, args)
    args = args or {}
    local is_plugin, plugin = pcall(require, target)

    local buffer = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[buffer].filetype

    if string.find(string.lower(filetype), string.lower(target:gsub('%.', ''))) then
        if is_plugin then
            plugin.close()
        else
            vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
        end
    else
        if is_plugin then
            plugin.open(unpack(args))
        else
            vim.cmd(target)
        end
    end
end

vim.keymap.set('n', '<Leader>g', function()
    toggle('Neogit')
end)
vim.keymap.set('n', '<Leader>li', function()
    toggle('LspInfo')
end)
vim.keymap.set('n', '<Leader>mf', function()
    toggle('mini.files', { vim.api.nvim_buf_get_name(0) })
end)
vim.keymap.set('n', '<Leader>pl', function()
    toggle('Lazy')
end)
vim.keymap.set('n', '<Leader>pm', function()
    toggle('Mason')
end)

vim.keymap.set('n', '<Leader>o', function()
    toggle('oil')
end)
vim.keymap.set('n', '<Leader>u', '<Cmd>UndotreeToggle<CR>')

local colorcolumn_values = { '', '120', '80' }
local current_colorcolumn_index = 1
local function toggle_colorcolumn()
    current_colorcolumn_index = current_colorcolumn_index % #colorcolumn_values + 1
    vim.opt.colorcolumn = colorcolumn_values[current_colorcolumn_index]
end

vim.keymap.set('n', '<Leader>tc', toggle_colorcolumn)
-- [[ Utilities ]]
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>') -- Stop the highlighting for the 'hlsearch' option when pressing `<Esc>`.
vim.keymap.set('x', '.', ':normal .<CR>') -- Repeat the last dot command in Visual mode.

-- [[ Windows ]]
-- Mapping
vim.keymap.set('n', '<Leader>w', '<C-w>')

-- Management
vim.keymap.set('n', '<Leader>wh', '<Cmd>leftabove vsplit<CR>')
vim.keymap.set('n', '<Leader>wj', '<Cmd>belowright split<CR>')
vim.keymap.set('n', '<Leader>wk', '<Cmd>aboveleft split<CR>')
vim.keymap.set('n', '<Leader>wl', '<Cmd>rightbelow vsplit<CR>')

-- Navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Full screen
vim.keymap.set('n', '<Leader>wf', '<C-w>_<C-w>|')

