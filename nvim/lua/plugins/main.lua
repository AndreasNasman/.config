return {
    {
        'catppuccin/nvim',
        config = function()
            vim.cmd.colorscheme('catppuccin-mocha')
            local mocha = require('catppuccin.palettes').get_palette('mocha')
            vim.api.nvim_set_hl(0, 'NormalFloat', {})
            vim.api.nvim_set_hl(0, 'FloatBorder', { fg = mocha.rosewater })
            vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { bg = mocha.surface1, fg = mocha.peach })
        end,
        lazy = false,
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
    { 'lewis6991/gitsigns.nvim', event = 'UIEnter', opts = {} },
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
            require('mini.files').setup({
                mappings = {
                    go_in_plus = '<CR>',
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
                    update_n_lines = '',

                    suffix_last = '',
                    suffix_next = '',
                },
            })
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'UIEnter',
    },
    {
        'NeogitOrg/neogit',
        cmd = 'Neogit',
        dependencies = { 'sindrets/diffview.nvim', 'nvim-lua/plenary.nvim' },
        opts = { kind = 'split' },
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
            highlight = {
                additional_vim_regex_highlighting = { 'ruby' },
                enable = true,
            },
            indent = {
                disable = { 'ruby' },
                enable = true,
            },
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
