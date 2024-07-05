return {
    {
        'stevearc/conform.nvim',
        cmd = { 'ConformInfo' },
        event = { 'BufWritePre' },
        keys = {
            {
                '<leader>lf',
                function()
                    require('conform').format({ async = true, lsp_fallback = true })
                end,
                desc = '[L]sp [F]ormat',
                mode = '',
            },
        },
        opts = {
            format_on_save = { lsp_fallback = true, timeout_ms = 500 },
            formatters_by_ft = {
                fish = { 'fish_indent' },
                html = { 'prettierd' },
                htmldjango = { 'djlint' },
                javascript = { 'prettierd' },
                json = { 'prettierd' },
                lua = { 'stylua' },
                markdown = { 'markdownlint' },
                python = { 'ruff_fix', 'ruff_format' },
            },
        },
    },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local luasnip = require('luasnip')
            luasnip.config.setup({})

            local cmp = require('cmp')
            cmp.setup({
                formatting = vim.tbl_deep_extend(
                    'force',
                    require('cmp.config').get().formatting,
                    { format = require('lspkind').cmp_format() }
                ),
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
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'lazydev', group_index = 0 },
                },
            })
        end,
        dependencies = {
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'onsails/lspkind.nvim',
            {
                'L3MON4D3/LuaSnip',
                build = 'make install_jsregexp',
                dependencies = {
                    {
                        'rafamadriz/friendly-snippets',
                        config = function()
                            require('luasnip.loaders.from_vscode').lazy_load()
                        end,
                    },
                },
            },
        },
        event = 'InsertEnter',
    },
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require('lint')

            lint.linters_by_ft = {
                markdown = { 'markdownlint' },
            }

            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                callback = function()
                    lint.try_lint()
                end,
                group = vim.api.nvim_create_augroup('lint', { clear = true }),
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end
                    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

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
                ['jinja-lsp'] = {},
                basedpyright = {},
                lua_ls = {},
                marksman = {},
                perlnavigator = {},
                pyright = {},
                tsserver = {},
            }

            require('mason').setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'djlint',
                'markdownlint',
                'prettierd',
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
        dependencies = {
            { 'j-hui/fidget.nvim', opts = {} },
            {
                'folke/lazydev.nvim',
                dependencies = { 'Bilal2453/luvit-meta' },
                ft = 'lua',
                opts = { library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } } },
            },
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
        },
        ft = { 'fish', 'html', 'javascript', 'json', 'lua', 'markdown', 'perl', 'python' },
    },
}
