return {
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
            require('mini.statusline').setup()
            require('mini.surround').setup()
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'UIEnter',
    },
    {
        'NeogitOrg/neogit',
        cmd = 'Neogit',
        dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
        opts = { kind = 'split' },
    },
    {
        'rcarriga/nvim-notify',
        init = function()
            vim.notify = require('notify')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
        lazy = false,
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
    { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, event = 'UIEnter', opts = {} },
    {
        'folke/tokyonight.nvim',
        init = function()
            vim.cmd.colorscheme('tokyonight')
            local colors = require('tokyonight.colors').setup()
            vim.cmd('highlight ColorColumn guibg=' .. colors.fg_gutter)
        end,
        lazy = false,
        opts = { style = 'night' },
        priority = 1000,
    },
    { 'mbbill/undotree', event = 'UIEnter' },
    {
        { 'tpope/vim-abolish', event = 'UIEnter' },
        { 'tpope/vim-sleuth', lazy = false },
    },
}
