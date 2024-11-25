local utils = require('utils')

-- [[ Prerequisites ]]
-- Separate <C-i> from <Tab>.
-- https://www.reddit.com/r/neovim/comments/vguomm/comment/id5p016/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
utils.map('<C-i>', '<C-i>')

-- [[ Clipboard ]]
-- Black hole
utils.map('<Leader>d', '"_d', { 'n', 'x' })
utils.map('<Leader>p', '"_c<C-r>"<esc>', 'x')

-- System
local function sync_to_system_clipboard()
    vim.fn.setreg('+', vim.fn.getreg('"'))
end

utils.map('<Leader>+', sync_to_system_clipboard)
utils.map('<Leader>Y', '"+y$', { 'n', 'x' })
utils.map('<Leader>y', '"+y', { 'n', 'x' })

-- [[ Diagnostics ]]
utils.map('<D-d>', vim.diagnostic.open_float)

-- [[ File path ]]
---@param pattern string
local function copy_file_path(pattern)
    local file_path = vim.fn.expand(pattern)
    vim.fn.setreg('"', file_path)
    vim.fn.setreg('+', file_path)
    vim.notify('File path copied to the clipboard: ' .. file_path, vim.log.levels.INFO)
end

utils.map('<Leader>pa', function()
    copy_file_path('%:p')
end)
utils.map('<Leader>pn', function()
    copy_file_path('%:t')
end)
utils.map('<Leader>pr', function()
    copy_file_path('%:~:.')
end)

-- [[ Fixes ]]
-- Make `<BS>` delete default snippet parameters (e.g., in the `function` snippet in JS/TS).
-- https://github.com/L3MON4D3/LuaSnip/issues/622
utils.map('<BS>', '<C-o>s', 's')

-- [[ History ]]
utils.map('<C-n>', '<Down>', 'c')
utils.map('<C-p>', '<Up>', 'c')

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
utils.map('[q', '<Cmd>cprevious<CR>')
utils.map(']q', '<Cmd>cnext<CR>')

-- [[ Tabs ]]
-- Management
utils.map('<Tab>n', '<Cmd>tabnew<CR>')
utils.map('<Tab>w', '<Cmd>tabclose<CR>')

-- Navigation
utils.map('<Tab>h', '<Cmd>tabprevious<CR>')
utils.map('<Tab>l', '<Cmd>tabnext<CR>')

utils.map('<Tab>1', '<Cmd>tabnext 1<CR>')
utils.map('<Tab>2', '<Cmd>tabnext 2<CR>')
utils.map('<Tab>3', '<Cmd>tabnext 3<CR>')
utils.map('<Tab>4', '<Cmd>tabnext 4<CR>')
utils.map('<Tab>5', '<Cmd>tabnext 5<CR>')
utils.map('<Tab>6', '<Cmd>tabnext 6<CR>')
utils.map('<Tab>7', '<Cmd>tabnext 7<CR>')
utils.map('<Tab>8', '<Cmd>tabnext 8<CR>')
utils.map('<Tab>9', '<Cmd>$tabnext<CR>')

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

utils.map('<Leader>B', function()
    toggle_command('Gitsigns blame', 'gitsigns-blame')
end)
utils.map('<Leader>li', function()
    toggle_command('LspInfo', 'checkhealth')
end)
utils.map('<Leader>m', function()
    toggle_command('Mason', 'mason')
end)
utils.map('<Leader>o', function()
    toggle_command('Oil', 'oil')
end)
utils.map('<Leader>q', function()
    toggle_command('copen', 'qf')
end)
utils.map('<Leader>z', function()
    toggle_command('Lazy', 'lazy')
end)

-- Options
---@param option string
local function toggleOption(option)
    local new_value = not vim.opt[option]:get()
    utils.notify_toggle(option, new_value)
    vim.opt[option] = new_value
end

utils.map('<Leader>tn', function()
    toggleOption('number')
end)
utils.map('<Leader>ts', function()
    toggleOption('spell')
end)

-- Other
utils.map('<Leader>tx', function()
    utils.notify_toggle('Treesitter context', not require('treesitter-context').enabled())
    vim.cmd('TSContextToggle')
end)
utils.map('<Leader>u', '<Cmd>UndotreeToggle<CR>')

-- [[ Utilities ]]
utils.map('.', ':normal .<CR>', 'x') -- Repeat the last dot command in Visual mode.
utils.map('<Esc>', '<Cmd>nohlsearch<CR>') -- Stop the highlighting for the 'hlsearch' option when pressing `<Esc>`.

-- [[ Windows ]]
-- Full screen
utils.map('<Leader>wf', '<C-w>_<C-w>|')

-- Management
utils.map('<Leader>wh', '<Cmd>leftabove vsplit<CR>')
utils.map('<Leader>wj', '<Cmd>belowright split<CR>')
utils.map('<Leader>wk', '<Cmd>aboveleft split<CR>')
utils.map('<Leader>wl', '<Cmd>rightbelow vsplit<CR>')

-- Mapping
utils.map('<Leader>w', '<C-w>')
