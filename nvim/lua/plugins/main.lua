return {
    {
        'catppuccin/nvim',
        config = function()
            vim.cmd.colorscheme('catppuccin-mocha')
            local mocha = require('catppuccin.palettes').get_palette('mocha')
            vim.api.nvim_set_hl(0, 'NormalFloat', {})
            vim.api.nvim_set_hl(0, 'FloatBorder', { fg = mocha.rosewater })
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
            require('mini.surround').setup()
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
        },
    },
    {
        'stevearc/oil.nvim',
        cmd = 'Oil',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
    },
    { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, event = 'UIEnter', opts = {} },
    { 'mbbill/undotree', event = 'UIEnter' },
    { 'tpope/vim-abolish', event = 'UIEnter' },
}
