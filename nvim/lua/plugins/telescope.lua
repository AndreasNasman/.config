return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        config = function()
            local telescope = require('telescope')
            local actions = require('telescope.actions')
            local builtin = require('telescope.builtin')
            local actions_state = require('telescope.actions.state')
            local file_browser = require('telescope').extensions.file_browser
            local fb_git = require('telescope._extensions.file_browser.git')
            local fb_utils = require('telescope._extensions.file_browser.utils')

            -- Setting strings to `false` seems to fall back to the default
            -- value in Telescope or the plugin.
            local opts_default = {
                cwd = false,
                grep_open_files = false,
                path = false,
                search_dirs = {},
                select_buffer = false,
            }
            local opts = vim.tbl_extend('error', opts_default, {
                additional_args = {},
                hidden = false,
                no_ignore = false,
            })

            ---Run builtin.
            ---@param command function
            ---@param opts_override? table
            local function run(command, opts_override)
                opts_override = vim.tbl_extend('force', opts_default, opts_override or {})
                opts = vim.tbl_extend('force', opts, opts_override)
                command(opts)
            end

            ---Run builtin with Git root as the cwd.
            ---@param command function
            local function run_with_git_cwd(command)
                return function()
                    local git_path = fb_git.find_root()
                    if not git_path then
                        vim.notify('Not in a Git project.')
                        return
                    end
                    run(command, { cwd = git_path })
                end
            end

            ---Notify opts.
            local function notify_opts()
                -- Adding `defer_fn` makes the notification appear asynchronous
                -- after, e.g., a picker has re-opened.
                vim.defer_fn(function()
                    vim.notify(vim.inspect(opts))
                end, 0)
            end

            local search_dirs = {}

            ---Run builtin with directories to search.
            ---@param command function
            local function run_with_search_dirs(command)
                if vim.tbl_isempty(search_dirs) then
                    vim.notify('No search directories selected.')
                    return
                end
                run(command, { search_dirs = search_dirs })
                notify_opts()
            end

            ---Set search directories.
            -- https://github.com/nvim-telescope/telescope-file-browser.nvim/wiki/Configuration-Recipes#live_grep-only-within-current-path-or-multi-selected-files
            ---@param prompt_bufnr number
            local function set_search_dirs(prompt_bufnr)
                local selections = fb_utils.get_selected_files(prompt_bufnr, false)
                search_dirs = vim.tbl_map(function(path)
                    return path:absolute()
                end, selections)
                if vim.tbl_isempty(search_dirs) then
                    local current_finder = actions_state.get_current_picker(prompt_bufnr).finder
                    search_dirs = { current_finder.path }
                end
            end

            ---Set and find files in selected directories.
            ---@param prompt_bufnr number
            local function find_files_selected_dirs(prompt_bufnr)
                set_search_dirs(prompt_bufnr)
                run_with_search_dirs(builtin.find_files)
            end

            ---Set and live grep in selected directories.
            ---@param prompt_bufnr number
            local function live_grep_selected_dirs(prompt_bufnr)
                set_search_dirs(prompt_bufnr)
                run_with_search_dirs(builtin.live_grep)
            end

            ---Notify the cwd.
            local function notify_cwd()
                vim.notify('cwd: ' .. vim.uv.cwd())
            end

            ---Set the cwd to the current directory without navigating into it.
            ---@param prompt_bufnr number
            local function change_cwd_custom(prompt_bufnr)
                local current_picker = actions_state.get_current_picker(prompt_bufnr)
                local cwd = current_picker.finder.path
                vim.cmd.cd(cwd)
                fb_utils.redraw_border_title(current_picker)
                notify_cwd()
            end

            ---Re-open the current picker.
            ---This function is a workaround function since Telescope currently
            ---does not allow modifying the open picker.
            ---https://github.com/nvim-telescope/telescope.nvim/issues/2016
            ---@param prompt_bufnr number
            local function reopen_picker(prompt_bufnr, command)
                local current_picker = actions_state.get_current_picker(prompt_bufnr)
                local _opts = { default_text = current_picker:_get_prompt() }
                actions.close(prompt_bufnr)
                command(vim.tbl_extend('force', opts, _opts))
                notify_opts()
            end

            ---Toggle option.
            ---@param option string
            ---@param prompt_bufnr number
            local function toggle_option(option, prompt_bufnr)
                opts[option] = not opts[option]
                local additional_args_length_before = #opts.additional_args
                opts.additional_args = vim.tbl_filter(function(element)
                    return element ~= '--' .. option
                end, opts.additional_args)
                if additional_args_length_before == #opts.additional_args then
                    table.insert(opts.additional_args, '--' .. option)
                end

                local current_picker = actions_state.get_current_picker(prompt_bufnr)
                local prompt_title = current_picker.prompt_title
                if prompt_title == 'File Browser' then
                    local finder = current_picker.finder
                    finder[option] = opts[option]
                    current_picker:refresh(finder, { reset_prompt = true, multi = current_picker._multi })
                    notify_opts()
                elseif prompt_title == 'Find Files' then
                    reopen_picker(prompt_bufnr, builtin.find_files)
                elseif prompt_title == 'Live Grep' then
                    reopen_picker(prompt_bufnr, builtin.live_grep)
                else
                    vim.notify('Unable to show the toggled option in the current picker.', vim.log.levels.WARN)
                end
            end

            ---Toggle .gitignore files.
            ---@param prompt_bufnr number
            local function toggle_gitignore(prompt_bufnr)
                toggle_option('no_ignore', prompt_bufnr)
            end

            ---Toggle hidden files.
            ---@param prompt_bufnr number
            local function toggle_hidden(prompt_bufnr)
                toggle_option('hidden', prompt_bufnr)
            end

            telescope.setup({
                defaults = {
                    layout_config = { height = 0.99, width = 0.99 },
                    mappings = {
                        n = {
                            ['<C-n>'] = actions.move_selection_next,
                            ['<C-p>'] = actions.move_selection_previous,

                            ['<Down>'] = actions.cycle_history_next,
                            ['<Up>'] = actions.cycle_history_prev,

                            ['<leader>h'] = toggle_hidden,
                            ['<leader>i'] = toggle_gitignore,

                            ['<leader>c'] = notify_cwd,
                            ['<leader>o'] = notify_opts,
                        },
                    },
                },
                extensions = {
                    file_browser = {
                        create_from_prompt = false,
                        hide_parent_dir = true,
                        hijack_netrw = true,
                        mappings = {
                            ['n'] = {
                                ['<leader>ssf'] = find_files_selected_dirs,
                                ['<leader>ssg'] = live_grep_selected_dirs,
                            },
                            ['i'] = { ['<C-t>'] = change_cwd_custom },
                        },
                        prompt_path = true,
                    },
                    ['ui-select'] = { require('telescope.themes').get_dropdown() },
                },
            })

            telescope.load_extension('file_browser')
            telescope.load_extension('fzf')
            telescope.load_extension('ui-select')

            --stylua: ignore start
            vim.keymap.set('n', '<leader>s/', function() run(builtin.live_grep, { grep_open_files = true }) end, { desc = '[S]earch [/] in open files' })
            vim.keymap.set('n', '<leader>sb', function() run(file_browser.file_browser) end, { desc = '[S]earch using Telescope File [B]rowser' })
            vim.keymap.set('n', '<leader>sB', run_with_git_cwd(file_browser.file_browser), { desc = '[S]earch using Telescope File [B]rowser with Git root as the cwd' })
            vim.keymap.set('n', '<leader>sc', function() run(file_browser.file_browser, { path = '%:p:h', select_buffer = true }) end, { desc = '[S]earch using Telescope File Browser with the [C]urrent file' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sf', function() run(builtin.find_files) end, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sF', run_with_git_cwd(builtin.find_files), { desc = '[S]earch [F]iles with Git root as the cwd' })
            vim.keymap.set('n', '<leader>sg', function() run(builtin.live_grep) end, { desc = '[S]earch using [G]rep' })
            vim.keymap.set('n', '<leader>sG', run_with_git_cwd(builtin.live_grep), { desc = '[[S]earch using [G]rep with Git root as the cwd' })
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp pages' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sm', builtin.man_pages, { desc = '[S]earch [M]an pages' })
            vim.keymap.set('n', '<leader>sn', function() run(builtin.find_files, { cwd = vim.fn.stdpath('config') }) end, { desc = '[S]earch [N]eovim files' })
            vim.keymap.set('n', '<leader>so', builtin.buffers, { desc = '[S]earch [O]pen files' })
            vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[S]earch [R]ecent files' })
            vim.keymap.set('n', '<leader>sR', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>ssf', function() run_with_search_dirs(builtin.find_files) end, { desc = '[S]earch [S]elected directories using [F]ind' })
            vim.keymap.set('n', '<leader>ssg', function() run_with_search_dirs(builtin.live_grep) end, { desc = '[S]earch [S]elected directories using [G]rep' })
            vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch [T]elescope builtins' })
            --stylua: ignore end
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        event = 'UIEnter',
    },
}
