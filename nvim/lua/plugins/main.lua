local utils = require('utils')

return {
    {
        'andymass/vim-matchup',
        config = function()
            vim.g.matchup_matchparen_offscreen = {}
        end,
        lazy = false,
    },
    {
        'catppuccin/nvim',
        lazy = false,
        init = function()
            vim.cmd.colorscheme('catppuccin')
            local palette = require('catppuccin.palettes').get_palette()
            local color_utils = require('catppuccin.utils.colors')
            vim.api.nvim_set_hl(0, 'NormalFloat', {})
            vim.api.nvim_set_hl(0, 'FloatBorder', { fg = palette.rosewater })
            vim.api.nvim_set_hl(0, 'GitSignsAddInline', { bg = color_utils.darken(palette.green, 0.36, palette.base) })
            vim.api.nvim_set_hl(0, 'GitSignsDeleteInline', { bg = color_utils.darken(palette.red, 0.36, palette.base) })
            vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { fg = palette.base, bg = palette.flamingo })
            vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { fg = palette.base, bg = palette.lavender })
        end,
        name = 'catppuccin',
        opts = {
            flavour = 'mocha',
            integrations = {
                blink_cmp = true,
                mason = true,
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
    { 'danymat/neogen', config = true, event = 'UIEnter' },
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
            require('mini.statusline').setup({
                content = {
                    active = function()
                        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                        local git = MiniStatusline.section_git({ trunc_width = 40 })
                        git = git:match('.*%d+') or git
                        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                        local filename = MiniStatusline.section_filename({ trunc_width = 140 })
                        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })

                        return MiniStatusline.combine_groups({
                            { hl = mode_hl, strings = { mode } },
                            { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
                            '%<',
                            { hl = 'MiniStatuslineFilename', strings = { filename } },
                            '%=',
                            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                        })
                    end,
                },
            })
            require('mini.surround').setup({
                mappings = {
                    add = '<D-s>a',
                    delete = '<D-s>d',
                    find = '',
                    find_left = '',
                    highlight = '',
                    replace = '<D-s>r',
                    suffix_last = '',
                    suffix_next = '',
                    update_n_lines = '',
                },
            })
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'UIEnter',
    },
    { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, event = 'UIEnter', opts = {} },
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        opts = {
            attach_to_untracked = true,
            current_line_blame = true,
            on_attach = function(buffer)
                local gitsigns = require('gitsigns')

                ---@param lhs string
                ---@param rhs string|function
                local function buffer_map(lhs, rhs)
                    utils.map(lhs, rhs, nil, { buffer = buffer })
                end

                buffer_map(']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)
                buffer_map('[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                buffer_map('<Leader>b', function()
                    gitsigns.blame_line({ full = true })
                end)
                buffer_map('<Leader>h', function()
                    gitsigns.preview_hunk()
                end)
            end,
        },
    },
    { 'mbbill/undotree', event = 'UIEnter' },
    {
        'mikesmithgh/kitty-scrollback.nvim',
        cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
        event = { 'User KittyScrollbackLaunch' },
        opts = {},
    },
    {
        'mrjones2014/smart-splits.nvim',
        build = './kitty/install-kittens.bash',
        config = function(_, opts)
            local smart_splits = require('smart-splits')

            -- Movement
            utils.map('<D-H>', function()
                smart_splits.swap_buf_left({ move_cursor = true })
            end)
            utils.map('<D-J>', function()
                smart_splits.swap_buf_down({ move_cursor = true })
            end)
            utils.map('<D-K>', function()
                smart_splits.swap_buf_up({ move_cursor = true })
            end)
            utils.map('<D-L>', function()
                smart_splits.swap_buf_right({ move_cursor = true })
            end)

            -- Navigation
            utils.map('<D-h>', smart_splits.move_cursor_left)
            utils.map('<D-j>', smart_splits.move_cursor_down)
            utils.map('<D-k>', smart_splits.move_cursor_up)
            utils.map('<D-l>', smart_splits.move_cursor_right)

            -- Resizing
            utils.map('<C-D-h>', smart_splits.resize_left, { 'n', 'x' })
            utils.map('<C-D-j>', smart_splits.resize_down, { 'n', 'x' })
            utils.map('<C-D-k>', smart_splits.resize_up, { 'n', 'x' })
            utils.map('<C-D-l>', smart_splits.resize_right, { 'n', 'x' })
            utils.map('<C-D-=>', '<C-w>=', { 'n', 'x' })

            smart_splits.setup(opts)
        end,
        opts = { at_edge = 'stop' },
        lazy = false,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = { 'nvim-treesitter/nvim-treesitter-context', opts = { enable = false } },
        lazy = false,
        main = 'nvim-treesitter.configs',
        opts = {
            auto_install = true,
            ensure_installed = { 'lua', 'luadoc', 'vim', 'vimdoc' },
            highlight = { additional_vim_regex_highlighting = { 'ruby' }, enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    node_decremental = '<BS>',
                    node_incremental = '<CR>',
                    scope_incremental = false,
                },
            },
            indent = { disable = { 'ruby' }, enable = true },
            matchup = { enable = true },
        },
    },
    {
        'stevearc/oil.nvim',
        cmd = 'Oil',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'UIEnter',
        opts = {},
    },
    { 'tpope/vim-abolish', event = 'UIEnter' },
    { 'tpope/vim-sleuth', lazy = false },
    { 'windwp/nvim-ts-autotag', event = 'UIEnter', opts = {} },
}
