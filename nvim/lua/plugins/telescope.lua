return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        config = function()
            local telescope = require('telescope')
            local actions = require('telescope.actions')
            local builtin = require('telescope.builtin')
            local actions_state = require('telescope.actions.state')

            local opts = {
                additional_args = {},
                hidden = false,
                no_ignore = false,
            }

            ---Run builtin.
            ---@param command function
            ---@param opts_override? table
            local function run(command, opts_override)
                command(vim.tbl_extend('force', opts, opts_override or {}))
            end

            ---Notify opts.
            local function notify_opts()
                vim.notify(vim.inspect(opts, { newline = ' ', indent = '' }), vim.log.levels.INFO)
            end

            ---Re-open the current picker.
            ---This function is a workaround function since Telescope currently
            ---does not allow modifying the open picker.
            ---https://github.com/nvim-telescope/telescope.nvim/issues/2016
            ---@param current_picker table
            ---@param prompt_bufnr number
            ---@param command function
            local function reopen_picker(current_picker, prompt_bufnr, command)
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
                if prompt_title == 'Find Files' then
                    reopen_picker(current_picker, prompt_bufnr, builtin.find_files)
                elseif prompt_title == 'Live Grep' then
                    reopen_picker(current_picker, prompt_bufnr, builtin.live_grep)
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

            ---Notify the cwd.
            local function notify_cwd()
                vim.notify('cwd: ' .. vim.uv.cwd(), vim.log.levels.INFO)
            end

            telescope.setup({
                defaults = {
                    layout_config = { height = 0.99, width = 0.99 },
                    layout_strategy = 'vertical',
                    mappings = {
                        n = {
                            ['<C-n>'] = actions.move_selection_next,
                            ['<C-p>'] = actions.move_selection_previous,

                            ['<Down>'] = actions.cycle_history_next,
                            ['<Up>'] = actions.cycle_history_prev,

                            ['<Leader>h'] = toggle_hidden,
                            ['<Leader>i'] = toggle_gitignore,

                            ['<Leader>c'] = notify_cwd,
                            ['<Leader>o'] = notify_opts,
                        },
                    },
                },
                extensions = {
                    ['ui-select'] = { require('telescope.themes').get_dropdown() },
                },
            })

            telescope.load_extension('fzf')
            telescope.load_extension('ui-select')

            vim.keymap.set('n', '<Leader>s/', function() run(builtin.live_grep, { grep_open_files = true }) end)
            vim.keymap.set('n', '<Leader>sd', builtin.diagnostics)
            vim.keymap.set('n', '<Leader>sf', function() run(builtin.find_files) end)
            vim.keymap.set('n', '<Leader>sg', function() run(builtin.live_grep) end)
            vim.keymap.set('n', '<Leader>sh', builtin.help_tags)
            vim.keymap.set('n', '<Leader>sk', builtin.keymaps)
            vim.keymap.set('n', '<Leader>sm', builtin.man_pages)
            vim.keymap.set('n', '<Leader>sn', function() run(builtin.find_files, { cwd = vim.fn.stdpath('config') }) end)
            vim.keymap.set('n', '<Leader>so', builtin.buffers)
            vim.keymap.set('n', '<Leader>sr', builtin.oldfiles)
            vim.keymap.set('n', '<Leader>sR', builtin.resume)
            vim.keymap.set('n', '<Leader>st', builtin.builtin)
        end,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-telescope/telescope-ui-select.nvim',
        },
        event = 'UIEnter',
    },
}
