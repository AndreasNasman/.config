return {
    {
        'catppuccin/nvim',
        lazy = false,
        init = function()
            vim.cmd.colorscheme('catppuccin-mocha')
            local palette = require('catppuccin.palettes').get_palette('mocha')
            local color_utils = require('catppuccin.utils.colors')
            vim.api.nvim_set_hl(0, 'NormalFloat', {})
            vim.api.nvim_set_hl(0, 'FloatBorder', { fg = palette.rosewater })
            vim.api.nvim_set_hl(0, 'GitSignsAddInline', { bg = color_utils.darken(palette.green, 0.36, palette.base) })
            vim.api.nvim_set_hl(0, 'GitSignsDeleteInline', { bg = color_utils.darken(palette.red, 0.36, palette.base) })
        end,
        name = 'catppuccin',
        opts = {
            integrations = {
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
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        opts = {
            attach_to_untracked = true,
            current_line_blame = true,
            on_attach = function(buffer)
                local gitsigns = require('gitsigns')

                local function map(lhs, rhs, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, lhs, rhs, { buffer = buffer })
                end

                map(']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)
                map('[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                map('<Leader>b', function()
                    gitsigns.blame_line({ full = true })
                end)
                map('<Leader>h', function()
                    gitsigns.preview_hunk()
                end)
            end,
        },
    },
    {
        'mikesmithgh/kitty-scrollback.nvim',
        cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
        event = { 'User KittyScrollbackLaunch' },
        opts = {},
    },
    {
        'iamcco/markdown-preview.nvim',
        build = function()
            vim.fn['mkdp#util#install']()
        end,
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
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
            require('mini.statusline').setup()
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
    { 'danymat/neogen', config = true, event = 'UIEnter' },
    {
        'mrjones2014/smart-splits.nvim',
        build = './kitty/install-kittens.bash',
        config = function(_, opts)
            local smart_splits = require('smart-splits')

            -- Movement
            vim.keymap.set('n', '<D-H>', function()
                smart_splits.swap_buf_left({ move_cursor = true })
            end)
            vim.keymap.set('n', '<D-J>', function()
                smart_splits.swap_buf_down({ move_cursor = true })
            end)
            vim.keymap.set('n', '<D-K>', function()
                smart_splits.swap_buf_up({ move_cursor = true })
            end)
            vim.keymap.set('n', '<D-L>', function()
                smart_splits.swap_buf_right({ move_cursor = true })
            end)

            -- Navigation
            vim.keymap.set('n', '<D-h>', smart_splits.move_cursor_left)
            vim.keymap.set('n', '<D-j>', smart_splits.move_cursor_down)
            vim.keymap.set('n', '<D-k>', smart_splits.move_cursor_up)
            vim.keymap.set('n', '<D-l>', smart_splits.move_cursor_right)

            -- Resizing
            vim.keymap.set('n', '<C-D-h>', smart_splits.resize_left)
            vim.keymap.set('n', '<C-D-j>', smart_splits.resize_down)
            vim.keymap.set('n', '<C-D-k>', smart_splits.resize_up)
            vim.keymap.set('n', '<C-D-l>', smart_splits.resize_right)
            vim.keymap.set('n', '<C-D-=>', '<C-w>=')

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
            indent = { disable = { 'ruby' }, enable = true },
            matchup = { enable = true },
        },
    },
    { 'windwp/nvim-ts-autotag', event = 'UIEnter', opts = {} },
    {
        'stevearc/oil.nvim',
        cmd = 'Oil',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'UIEnter',
        opts = {},
    },
    { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, event = 'UIEnter', opts = {} },
    { 'mbbill/undotree', event = 'UIEnter' },
    { 'tpope/vim-abolish', event = 'UIEnter' },
    { 'andymass/vim-matchup', lazy = false },
    { 'tpope/vim-sleuth', lazy = false },
}
