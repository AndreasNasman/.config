local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        'catppuccin/nvim',
        init = function()
            vim.cmd.colorscheme('catppuccin-mocha')
        end,
        name = 'catppuccin',
        opts = {
            integrations = {
                mini = { enabled = true },
                native_lsp = {
                    underlines = {
                        errors = { 'undercurl' },
                        hints = { 'undercurl' },
                        information = { 'undercurl' },
                        warnings = { 'undercurl' },
                    },
                },
            },
        },
        priority = 1000,
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            luasnip.config.setup({})

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

                    ['<CR>'] = cmp.mapping.confirm(),
                    ['<S-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),

                    ['<C-Space>'] = cmp.mapping.complete({}),

                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),

                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),
                }),
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = 'luasnip' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                },
            })
        end,
    },
    {
        'stevearc/conform.nvim',
        cmd = { 'ConformInfo' },
        event = { 'BufWritePre' },
        opts = {
            format_on_save = { lsp_fallback = true, timeout_ms = 500 },
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'ruff_fix', 'ruff_format' },
            },
        },
    },
    { 'lewis6991/gitsigns.nvim', opts = {} },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'j-hui/fidget.nvim', opts = { progress = { display = { done_icon = '󰄬' } } } },
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'folke/neodev.nvim', opts = {} },
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            local servers = {
                basedpyright = {},
                lua_ls = {},
                perlnavigator = {},
            }

            require('mason').setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'ruff',
                'stylua',
            })
            require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

            require('mason-lspconfig').setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            })
        end,
    },
    {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.ai').setup({
                custom_textobjects = {
                    g = function()
                        return {
                            from = { col = 1, line = 1 },
                            to = { col = math.max(vim.fn.getline('$'):len(), 1), line = vim.fn.line('$') },
                        }
                    end,
                },
            })
            require('mini.comment').setup()
            require('mini.statusline').setup()
            require('mini.surround').setup()
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'rcarriga/nvim-notify',
        init = function()
            vim.notify = require('notify')
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')
            local actions_state = require('telescope.actions.state')
            local fb_git = require('telescope._extensions.file_browser.git')
            local fb_utils = require('telescope._extensions.file_browser.utils')

            local search_dirs = {}
            local search_dirs_titles = {}

            ---Set search directories for Telescope.
            ---The search directories are absolute paths that we truncated to
            ---start from the Git root, if applicable, or the cwd. If an
            ---absolute path is outside both base paths, we display it as is.
            ---@param prompt_bufnr number
            local function set_search_dirs(prompt_bufnr)
                search_dirs = {}
                search_dirs_titles = {}

                -- https://github.com/nvim-telescope/telescope-file-browser.nvim/wiki/Configuration-Recipes#live_grep-only-within-current-path-or-multi-selected-files
                local selections = fb_utils.get_selected_files(prompt_bufnr, false)
                search_dirs = vim.tbl_map(function(path)
                    return path:absolute()
                end, selections)
                if vim.tbl_isempty(search_dirs) then
                    local current_finder = actions_state.get_current_picker(prompt_bufnr).finder
                    search_dirs = { current_finder.path }
                end

                local git_path = fb_git.find_root() or ''
                local cwd_path = vim.uv.cwd() or ''
                ---@type string
                local git_dir = git_path:match('.*/(.*)$') or git_path
                ---@type string
                local cwd_dir = cwd_path:match('.*/(.*)$') or cwd_path

                for _, search_dir in pairs(search_dirs) do
                    if #git_path > 0 and search_dir:sub(1, #git_path) == git_path then
                        table.insert(search_dirs_titles, (search_dir:gsub(git_path, git_dir)))
                    elseif #cwd_path > 0 and search_dir:sub(1, #cwd_path) == cwd_path then
                        table.insert(search_dirs_titles, (search_dir:gsub(cwd_path, cwd_dir)))
                    else
                        table.insert(search_dirs_titles, search_dir)
                    end
                end
            end

            local function find_files_selected_dirs()
                if vim.tbl_isempty(search_dirs) then
                    vim.notify('No search directories selected!')
                    return
                end
                require('telescope.builtin').find_files({
                    prompt_title = 'Find Files (' .. table.concat(search_dirs_titles, ', ') .. ')',
                    search_dirs = search_dirs,
                })
            end

            local function live_grep_selected_dirs()
                if vim.tbl_isempty(search_dirs) then
                    vim.notify('No search directories selected!')
                    return
                end
                require('telescope.builtin').live_grep({
                    prompt_title = 'Live Grep (' .. table.concat(search_dirs_titles, ', ') .. ')',
                    search_dirs = search_dirs,
                })
            end

            ---Set and find files in selected directories.
            ---@param prompt_bufnr number
            local function find_files_in_selected_dirs(prompt_bufnr)
                set_search_dirs(prompt_bufnr)
                find_files_selected_dirs()
            end

            ---Set and live grep in selected directories.
            ---@param prompt_bufnr number
            local function live_grep_in_selected_dirs(prompt_bufnr)
                set_search_dirs(prompt_bufnr)
                live_grep_selected_dirs()
            end

            ---Set cwd to the current directory without navigating into it.
            ---@param prompt_bufnr number
            local function change_cwd_custom(prompt_bufnr)
                local current_picker = actions_state.get_current_picker(prompt_bufnr)
                local cwd = current_picker.finder.path
                vim.cmd('cd ' .. cwd)
                fb_utils.redraw_border_title(current_picker)
                vim.notify('Changing cwd: ' .. cwd)
            end

            telescope.setup({
                defaults = {
                    layout_config = { height = 0.99, width = 0.99 },
                    mappings = {
                        n = {
                            ['<C-n>'] = 'move_selection_next',
                            ['<C-p>'] = 'move_selection_previous',
                        },
                    },
                },
                extensions = {
                    file_browser = {
                        create_from_prompt = false,
                        hijack_netrw = true,
                        mappings = {
                            ['n'] = {
                                ['<leader>sdf'] = find_files_in_selected_dirs,
                                ['<leader>sdg'] = live_grep_in_selected_dirs,
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

            ---Run Telescope builtin with Git root as cwd.
            ---@param command function
            local function run_git_cwd(command)
                local git_path = fb_git.find_root()
                if not git_path then
                    vim.notify('No Git path found!')
                    return
                end
                command({ cwd = git_path })
            end
            --stylua: ignore start
            vim.keymap.set('n', '<leader>sdf', find_files_selected_dirs, { desc = '[S]earch selected [D]irectories by [F]ind' })
            vim.keymap.set('n', '<leader>sdg', live_grep_selected_dirs, { desc = '[S]earch selected [D]irectories by [G]rep' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sF', function() run_git_cwd(builtin.find_files) end, { desc = '[S]earch [F]iles with Git root as cwd' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sG', function() run_git_cwd(builtin.live_grep) end, { desc = '[[S]earch by [G]rep with Git root as cwd' })
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = '[S]earch [Old] files' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            --stylua: ignore end
        end,
    },
    { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} },
    { 'tpope/vim-sleuth', 'tpope/vim-abolish' },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
        opts = {
            auto_install = true,
            ensure_installed = { 'lua', 'luadoc', 'vim', 'vimdoc' },
            highlight = {
                additional_vim_regex_highlighting = { 'ruby' },
                enable = true,
            },
            indent = {
                disable = { 'ruby' },
                enable = true,
            },
        },
    },
}, {
    install = { colorscheme = { 'catppuccin' } },
})
