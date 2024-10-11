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
                mode = 'n',
            },
        },
        opts = {
            format_on_save = { lsp_format = 'fallback' },
            formatters = {
                ['biome-check'] = { append_args = { '--unsafe' } },
                prettierd = { append_args = { '--use-tabs' } },
            },
            formatters_by_ft = {
                css = { 'prettierd', 'biome-check' },
                fish = { 'fish_indent' },
                html = { 'prettierd' },
                htmldjango = { 'djlint' },
                javascript = { 'biome-check' },
                json = { 'biome-check' },
                jsonc = { 'biome-check' },
                lua = { 'stylua' },
                markdown = { 'markdownlint' },
                python = { 'ruff_fix', 'ruff_format' },
                svelte = { 'prettierd', 'biome-check' },
                toml = { 'taplo' },
                typescript = { 'biome-check' },
                zsh = { 'beautysh' },
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
                    {
                        name = 'buffer',
                        -- Completion based on all open buffers.
                        option = {
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs()
                            end,
                        },
                    },
                },
                window = {
                    completion = {
                        border = 'rounded',
                        winhighlight = 'Normal:None',
                    },
                    documentation = {
                        border = 'rounded',
                        winhighlight = 'Normal:None',
                    },
                },
            })

            -- Completions for `/` search based on the current buffer.
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                },
            })

            -- Completions for command mode.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' },
                        },
                    },
                }),
            })
        end,
        dependencies = {
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
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
        event = 'UIEnter',
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
                    local map = function(lhs, rhs, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, lhs, rhs, { buffer = event.buf })
                    end

                    map('<D-k>', vim.lsp.buf.signature_help, { 'n', 'x', 'i' })
                    map('<Leader>la', vim.lsp.buf.code_action, { 'n', 'x' })
                    map('<Leader>ld', require('telescope.builtin').lsp_document_symbols)
                    map('<Leader>lr', vim.lsp.buf.rename)
                    map('<Leader>lt', require('telescope.builtin').lsp_type_definitions)
                    map('<Leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols)
                    map('gd', require('telescope.builtin').lsp_definitions)
                    map('gD', vim.lsp.buf.declaration)
                    map('gI', require('telescope.builtin').lsp_implementations)
                    map('gr', require('telescope.builtin').lsp_references)

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
                        map('<Leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                        end)
                    end
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            local lspconfig = require('lspconfig')
            local function is_deno_project()
                return lspconfig.util.root_pattern('deno.json', 'deno.jsonc')
            end

            require('mason').setup({
                ui = {
                    border = 'rounded',
                    height = 0.8,
                },
            })

            local servers = {
                ['jinja-lsp'] = {},
                basedpyright = {},
                beautysh = {},
                biome = {},
                cssls = {},
                denols = { root_dir = is_deno_project() },
                djlint = {},
                jsonls = {},
                lua_ls = { settings = { Lua = { hint = { enable = true } } } },
                markdownlint = {},
                marksman = {},
                perlnavigator = {},
                prettierd = {},
                pyright = {},
                ruff = {},
                stylua = {},
                svelte = {},
                tailwindcss = {},
                taplo = {},
                ts_ls = {
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
                    root_dir = function(startpath)
                        if is_deno_project()(startpath) then
                            return nil
                        end

                        return lspconfig.util.root_pattern('package.json', 'tsconfig.json')(startpath)
                    end,
                    settings = { implicitProjectConfiguration = { target = 'ESNext' } },
                    single_file_support = not is_deno_project()(vim.fn.getcwd()),
                },
            }

            require('mason-tool-installer').setup({ ensure_installed = vim.tbl_keys(servers) })

            require('mason-lspconfig').setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            })

            require('lspconfig.ui.windows').default_options.border = 'rounded'
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
            'css',
            'fish',
            'html',
            'javascript',
            'json',
            'jsonc',
            'lua',
            'markdown',
            'perl',
            'python',
            'svelte',
            'toml',
            'typescript',
            'zsh',
        },
    },
}
