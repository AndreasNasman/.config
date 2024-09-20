-- [[ Clipboard ]]
-- Black hole
vim.keymap.set('x', '<Leader>p', '"_c<C-r>"<esc>')
vim.keymap.set({ 'n', 'x' }, '<Leader>d', '"_d')

-- System
local function sync_to_system_clipboard()
    vim.fn.setreg('+', vim.fn.getreg('"'))
end

vim.keymap.set('n', '<Leader>+', sync_to_system_clipboard)
vim.keymap.set({ 'n', 'x' }, '<Leader>Y', '"+y$')
vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')

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

vim.keymap.set('n', '<Leader>pa', function()
    copy_file_path('%:p')
end)
vim.keymap.set('n', '<Leader>pn', function()
    copy_file_path('%:t')
end)
vim.keymap.set('n', '<Leader>pr', function()
    copy_file_path('%:~:.')
end)

-- [[ Fixes ]]
-- Make `<BS>` delete default snippet parameters (e.g., in the `function` snippet in JS/TS).
-- https://github.com/L3MON4D3/LuaSnip/issues/622
vim.keymap.set('s', '<BS>', '<C-o>s')

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
vim.keymap.set('n', '<M-[>', '<Cmd>tabprevious<CR>')
vim.keymap.set('n', '<M-]>', '<Cmd>tabnext<CR>')

-- [[ Toggles ]]
local colorcolumn_values = { '', '120', '80' }
local current_colorcolumn_index = 1
local function toggle_colorcolumn()
    current_colorcolumn_index = current_colorcolumn_index % #colorcolumn_values + 1
    vim.opt.colorcolumn = colorcolumn_values[current_colorcolumn_index]
end

vim.keymap.set('n', '<Leader>c', toggle_colorcolumn)

---@param target string
---@param args { is_open: function|nil, opts: table|nil } | nil
local function toggle(target, args)
    args = args or {}
    local opts = args.opts or {}
    local is_open = args.is_open
        or function()
            local buffer = vim.api.nvim_get_current_buf()
            local filetype = vim.bo[buffer].filetype
            return string.find(string.lower(filetype), string.lower(target:gsub('%.', '')))
        end

    local is_plugin, plugin = pcall(require, target)

    if is_open() then
        if is_plugin then
            plugin.close()
        else
            vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
        end
    else
        if is_plugin then
            plugin.open(unpack(opts))
        else
            vim.cmd(target)
        end
    end
end

vim.keymap.set('n', '<Leader>f', function()
    toggle('mini.files', { opts = { vim.api.nvim_buf_get_name(0) } })
end)
vim.keymap.set('n', '<Leader>g', function()
    toggle('Neogit')
end)
vim.keymap.set('n', '<Leader>li', function()
    toggle('LspInfo')
end)
vim.keymap.set('n', '<Leader>m', function()
    toggle('Mason')
end)
vim.keymap.set('n', '<Leader>o', function()
    toggle('oil')
end)
vim.keymap.set('n', '<Leader>q', function()
    toggle('copen', {
        is_open = function()
            local buffer = vim.api.nvim_get_current_buf()
            local buftype = vim.api.nvim_get_option_value('buftype', { buf = buffer })
            return buftype == 'quickfix'
        end,
    })
end)
vim.keymap.set('n', '<Leader>z', function()
    toggle('Lazy')
end)

vim.keymap.set('n', '<Leader>u', '<Cmd>UndotreeToggle<CR>')

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
