return {
    { 'Bilal2453/luvit-meta', lazy = true },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = { library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } } },
    },
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require('lint')

            lint.linters_by_ft = { markdown = { 'markdownlint' } }

            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                callback = function()
                    if vim.opt_local.modifiable:get() then
                        lint.try_lint()
                    end
                end,
                group = vim.api.nvim_create_augroup('nasse-lint', { clear = true }),
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('nasse-lsp-attach', { clear = true }),
                callback = function(event)
                    local function map(lhs, rhs, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, lhs, rhs, { buffer = event.buf })
                    end

                    map('<C-k>', vim.lsp.buf.signature_help, { 'n', 'x', 'i' })
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
                            local new_value = not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                            vim.notify(
                                string.format('Toggling inlay hints %s', new_value and 'on' or 'off'),
                                vim.log.levels.INFO
                            )
                            vim.lsp.inlay_hint.enable(new_value)
                        end)
                    end
                end,
            })

            require('mason').setup({ ui = { border = 'rounded', height = 0.8 } })

            local servers = {
                ['jinja-lsp'] = {},
                basedpyright = {},
                beautysh = {},
                cssls = {},
                denols = {},
                djlint = {},
                emmet_language_server = {},
                html = {},
                jsonls = {},
                lua_ls = { settings = { Lua = { hint = { enable = true } } } },
                markdownlint = {},
                marksman = {},
                perlnavigator = {},
                pyright = {},
                ruff = {},
                stylua = {},
                svelte = {},
                tailwindcss = {},
                taplo = {},
            }
            require('mason-tool-installer').setup({ ensure_installed = vim.tbl_keys(servers) })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            require('mason-lspconfig').setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend(
                            'force',
                            {},
                            capabilities,
                            server.capabilities or {},
                            require('blink.cmp').get_lsp_capabilities(server.capabilities)
                        )
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            })

            require('lspconfig.ui.windows').default_options.border = 'rounded'
        end,
        cmd = 'Mason',
        dependencies = {
            { 'j-hui/fidget.nvim', opts = {} },
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            'williamboman/mason-lspconfig.nvim',
            { 'williamboman/mason.nvim', config = true },
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
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        lazy = false,
        opts = {
            keymap = {
                preset = 'enter',
                ['<C-h>'] = { 'snippet_backward', 'fallback' },
                ['<C-l>'] = { 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<Tab>'] = { 'select_next', 'fallback' },
            },
            windows = {
                autocomplete = {
                    border = 'rounded',
                    selection = 'auto_insert',
                    winhighlight = 'Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None',
                },
                documentation = {
                    auto_show = true,
                    border = 'rounded',
                    winhighlight = 'Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None',
                },
            },
        },
        version = 'v0.*',
    },
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
            formatters_by_ft = {
                css = { 'deno_fmt' },
                fish = { 'fish_indent' },
                html = { 'deno_fmt' },
                htmldjango = { 'djlint' },
                javascript = { 'deno_fmt' },
                json = { 'deno_fmt' },
                jsonc = { 'deno_fmt' },
                lua = { 'stylua' },
                markdown = { 'markdownlint', 'deno_fmt' },
                python = { 'ruff_fix', 'ruff_format' },
                svelte = { 'deno_fmt' },
                toml = { 'taplo' },
                typescript = { 'deno_fmt' },
                zsh = { 'beautysh' },
            },
        },
    },
}
