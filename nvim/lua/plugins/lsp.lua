return {
    {
        'stevearc/conform.nvim',
        cmd = 'ConformInfo',
        event = 'BufWritePre',
        keys = {
            {
                '<Leader>lf',
                function()
                    require('conform').format({ async = true, lsp_format = 'fallback' })
                end,
                desc = '[L]sp [F]ormat',
                mode = '',
            },
        },
        opts = {
            format_on_save = { lsp_format = 'fallback' },
            formatters = { ['biome-check'] = { append_args = { '--unsafe' } } },
            formatters_by_ft = {
                fish = { 'fish_indent' },
                html = { 'prettierd' },
                htmldjango = { 'djlint' },
                javascript = { 'biome-check' },
                json = { 'biome-check' },
                lua = { 'stylua' },
                markdown = { 'markdownlint' },
                python = { 'ruff_fix', 'ruff_format' },
                typescript = { 'biome-check' },
            },
        },
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = { library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } } },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local luasnip = require('luasnip')
            luasnip.config.setup({})

            local cmp = require('cmp')

            local function get_custom_border()
                return cmp.config.window.bordered({
                    winhighlight = cmp.config.window.bordered().winhighlight:gsub(':FloatBorder', ':CustomFloatBorder'),
                })
            end

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
                    { name = 'lazydev', group_index = 0 },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                },
                window = {
                    completion = get_custom_border(),
                    documentation = get_custom_border(),
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
                group = vim.api.nvim_create_augroup('nasse-lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
                    end

                   --stylua: ignore start
                    map('<Leader>k', vim.lsp.buf.signature_help, 'LSP, signature help ([K] displays hover information)')
                    map('<Leader>la', vim.lsp.buf.code_action, '[L]SP, code [A]ction', { 'n', 'x' })
                    map('<Leader>ld', require('telescope.builtin').lsp_document_symbols, '[L]SP, [D]ocument symbols')
                    map('<Leader>lr', vim.lsp.buf.rename, '[L]SP, [R]ename')
                    map('<Leader>lt', require('telescope.builtin').lsp_type_definitions, '[L]SP, [T]ype definitions')
                    map('<Leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[L]SP, dynamic [W]orkspace symbols')
                    map('gd', require('telescope.builtin').lsp_definitions, 'LSP, [G]oto [D]efinitions')
                    map('gD', vim.lsp.buf.declaration, 'LSP, [G]oto [D]eclaration')
                    map('gI', require('telescope.builtin').lsp_implementations, 'LSP, [G]oto [I]mplementation')
                    map('gr', require('telescope.builtin').lsp_references, 'LSP, [G]oto [R]eferences')
                    --stylua: ignore end

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                        local highlight_augroup = vim.api.nvim_create_augroup('nasse-lsp-highlight', { clear = false })

                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                            group = highlight_augroup,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                            group = highlight_augroup,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({ group = 'nasse-lsp-highlight', buffer = event2.buf })
                            end,
                            group = vim.api.nvim_create_augroup('nasse-lsp-detach', { clear = true }),
                        })
                    end

                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                        end, '[T]oggle Inlay [H]ints')
                    end
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            local servers = {
                ['jinja-lsp'] = {},
                basedpyright = {},
                lua_ls = { settings = { Lua = { hint = { enable = true } } } },
                marksman = {},
                perlnavigator = {},
                pyright = {},
                tsserver = {
                    init_options = {
                        preferences = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = 'all',
                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                        },
                    },
                },
            }

            require('mason').setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'biome',
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
        cmd = 'Mason',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            { 'j-hui/fidget.nvim', opts = {} },
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
        },
        ft = {
            'fish',
            'html',
            'javascript',
            'json',
            'lua',
            'markdown',
            'perl',
            'python',
            'typescript',
        },
    },
}
