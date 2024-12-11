local utils = require('utils')

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

-- [[ Git ]]
---@param remote? string|nil
local function browse_git_file(remote)
    remote = remote or 'origin'

    local git_directory_path =
        vim.fs.find('.git', { limit = 1, path = vim.fn.expand('%:p'), type = 'directory', upward = true })[1]
    -- The path is ".git" when launched (mistakenly) from oil.nvim.
    if git_directory_path == nil or git_directory_path == '.git' then
        vim.notify('Not a Git repository', vim.log.levels.INFO)
        return
    end
    local project_path = git_directory_path:gsub('%.git$', '')

    local remote_url = vim.system({ 'git', '-C', project_path, 'config', '--get', 'remote.' .. remote .. '.url' })
        :wait().stdout
        :gsub('\n', '')
    if remote_url == nil or remote_url == '' then
        vim.notify('No URL defined for remote ' .. remote, vim.log.levels.INFO)
        return
    end

    local branch = vim.system({ 'git', '-C', project_path, 'branch', '--show-current' }):wait().stdout:gsub('\n', '')
    if branch == nil or branch == '' then
        vim.notify('No checked out branch')
        return
    end

    local absolute_file_path = vim.fn.expand('%:p')
    -- `gsub` matches regular expressions by default.
    -- We must escape magic characters with a %-sign to match literals.
    local escaped_project_path = project_path:gsub('[%-%_]', '%%%1')
    local project_relative_file_path = absolute_file_path:gsub(escaped_project_path, '')
    local line_number = vim.api.nvim_win_get_cursor(0)[1]

    if remote_url:match('github') or remote_url:match('gitlab') then
        vim.system({
            'open',
            string.format(
                '%s%s/blob/%s/%s#L%s',
                remote_url:gsub('%.git$', ''),
                remote_url:match('gitlab') and '/-' or '',
                branch,
                project_relative_file_path,
                line_number
            ),
        })
    else
        vim.notify('Unhandeled remote URL ' .. remote_url, vim.log.levels.info)
    end
end

utils.map('<Leader>gf', browse_git_file)

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

utils.map('j', add_move_with_count_to_jumplist('j'), nil, { expr = true })
utils.map('k', add_move_with_count_to_jumplist('k'), nil, { expr = true })

-- [[ Quickfix list ]]
utils.map('[q', '<Cmd>cprevious<CR>')
utils.map(']q', '<Cmd>cnext<CR>')

-- [[ Tabs ]]
-- Management
utils.map('<Leader><Tab>n', '<Cmd>tabnew<CR>')
utils.map('<Leader><Tab>w', '<Cmd>tabclose<CR>')

-- Navigation
utils.map('<D-[>', '<Cmd>tabprevious<CR>')
utils.map('<D-]>', '<Cmd>tabnext<CR>')
utils.map('<Leader><Tab>h', '<Cmd>tabprevious<CR>')
utils.map('<Leader><Tab>l', '<Cmd>tabnext<CR>')

utils.map('<Leader><Tab>1', '<Cmd>tabnext 1<CR>')
utils.map('<Leader><Tab>2', '<Cmd>tabnext 2<CR>')
utils.map('<Leader><Tab>3', '<Cmd>tabnext 3<CR>')
utils.map('<Leader><Tab>4', '<Cmd>tabnext 4<CR>')
utils.map('<Leader><Tab>5', '<Cmd>tabnext 5<CR>')
utils.map('<Leader><Tab>6', '<Cmd>tabnext 6<CR>')
utils.map('<Leader><Tab>7', '<Cmd>tabnext 7<CR>')
utils.map('<Leader><Tab>8', '<Cmd>tabnext 8<CR>')
utils.map('<Leader><Tab>9', '<Cmd>$tabnext<CR>')

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
