-- [[ Prerequisites ]]
-- Separate <C-i> from <Tab>.
-- https://www.reddit.com/r/neovim/comments/vguomm/comment/id5p016/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.keymap.set('n', '<C-i>', '<C-i>')

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

-- [[ History ]]
vim.keymap.set('c', '<C-n>', '<Down>')
vim.keymap.set('c', '<C-p>', '<Up>')

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
vim.keymap.set('n', '<Tab>n', '<Cmd>tabnew<CR>')
vim.keymap.set('n', '<Tab>w', '<Cmd>tabclose<CR>')

-- Navigation
vim.keymap.set('n', '<Tab>h', '<Cmd>tabprevious<CR>')
vim.keymap.set('n', '<Tab>l', '<Cmd>tabnext<CR>')

vim.keymap.set('n', '<Tab>1', '<Cmd>tabnext 1<CR>')
vim.keymap.set('n', '<Tab>2', '<Cmd>tabnext 2<CR>')
vim.keymap.set('n', '<Tab>3', '<Cmd>tabnext 3<CR>')
vim.keymap.set('n', '<Tab>4', '<Cmd>tabnext 4<CR>')
vim.keymap.set('n', '<Tab>5', '<Cmd>tabnext 5<CR>')
vim.keymap.set('n', '<Tab>6', '<Cmd>tabnext 6<CR>')
vim.keymap.set('n', '<Tab>7', '<Cmd>tabnext 7<CR>')
vim.keymap.set('n', '<Tab>8', '<Cmd>tabnext 8<CR>')
vim.keymap.set('n', '<Tab>9', '<Cmd>$tabnext<CR>')

-- [[ Toggle ]]
-- Commands
---@param command string
---@param filetype string
local function toggle_command(command, filetype)
    local is_open = vim.bo[vim.api.nvim_get_current_buf()].filetype == filetype
    if is_open then
        vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), {})
    else
        vim.cmd(command)
    end
end

vim.keymap.set('n', '<Leader>B', function()
    toggle_command('Gitsigns blame', 'gitsigns-blame')
end)
vim.keymap.set('n', '<Leader>li', function()
    toggle_command('LspInfo', 'checkhealth')
end)
vim.keymap.set('n', '<Leader>m', function()
    toggle_command('Mason', 'mason')
end)
vim.keymap.set('n', '<Leader>o', function()
    toggle_command('Oil', 'oil')
end)
vim.keymap.set('n', '<Leader>q', function()
    toggle_command('copen', 'qf')
end)
vim.keymap.set('n', '<Leader>z', function()
    toggle_command('Lazy', 'lazy')
end)

-- Options
local function toggleOption(option)
    local new_value = not vim.opt[option]:get()
    vim.notify(string.format('Toggling option `%s` %s', option, new_value and 'on' or 'off'), vim.log.levels.INFO)
    vim.opt[option] = new_value
end

vim.keymap.set('n', '<Leader>tn', function()
    toggleOption('number')
end)
vim.keymap.set('n', '<Leader>ts', function()
    toggleOption('spell')
end)

-- Other
vim.keymap.set('n', '<Leader>tx', function()
    vim.notify(
        string.format('Toggling Treesitter context %s', not require('treesitter-context').enabled() and 'on' or 'off'),
        vim.log.levels.INFO
    )
    vim.cmd('TSContextToggle')
end)
vim.keymap.set('n', '<Leader>u', '<Cmd>UndotreeToggle<CR>')

-- [[ Utilities ]]
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>') -- Stop the highlighting for the 'hlsearch' option when pressing `<Esc>`.
vim.keymap.set('x', '.', ':normal .<CR>') -- Repeat the last dot command in Visual mode.

-- [[ Windows ]]
-- Full screen
vim.keymap.set('n', '<Leader>wf', '<C-w>_<C-w>|')

-- Management
vim.keymap.set('n', '<Leader>wh', '<Cmd>leftabove vsplit<CR>')
vim.keymap.set('n', '<Leader>wj', '<Cmd>belowright split<CR>')
vim.keymap.set('n', '<Leader>wk', '<Cmd>aboveleft split<CR>')
vim.keymap.set('n', '<Leader>wl', '<Cmd>rightbelow vsplit<CR>')

-- Mapping
vim.keymap.set('n', '<Leader>w', '<C-w>')
