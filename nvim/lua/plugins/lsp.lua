local utils = require('utils')

local blink_completion_winhighlight = 'Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None'

return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
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
                    ---@param lhs string
                    ---@param rhs string|function
                    ---@param mode string|string[]|nil
                    local function buffer_map(lhs, rhs, mode)
                        utils.map(lhs, rhs, mode, { buffer = event.buf })
                    end

                    local config = { border = 'rounded' }

                    buffer_map('<C-k>', function()
                        vim.lsp.buf.signature_help(config)
                    end, { 'n', 'x', 'i' })
                    buffer_map('<Leader>la', vim.lsp.buf.code_action, { 'n', 'x' })
                    buffer_map('<Leader>ld', require('telescope.builtin').lsp_document_symbols)
                    buffer_map('<Leader>lr', vim.lsp.buf.rename)
                    buffer_map('<Leader>lt', require('telescope.builtin').lsp_type_definitions)
                    buffer_map('<Leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols)
                    buffer_map('gd', require('telescope.builtin').lsp_definitions)
                    buffer_map('gD', vim.lsp.buf.declaration)
                    buffer_map('gI', require('telescope.builtin').lsp_implementations)
                    buffer_map('gr', require('telescope.builtin').lsp_references)
                    buffer_map('K', function()
                        vim.lsp.buf.hover(config)
                    end)

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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

                    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        buffer_map('<Leader>th', function()
                            local new_value = not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                            utils.notify_toggle('inlay hints', new_value)
                            vim.lsp.inlay_hint.enable(new_value)
                        end)
                    end
                end,
            })

            local servers = {
                ['jinja-lsp'] = {},
                ['nil'] = {},
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
                shfmt = {},
                stylua = {},
                svelte = {},
                tailwindcss = {},
                taplo = {},
            }
            require('mason-tool-installer').setup({ ensure_installed = vim.tbl_keys(servers) })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            require('mason-lspconfig').setup({
                automatic_installation = false,
                ensure_installed = {},
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
            { 'williamboman/mason.nvim', opts = { ui = { border = 'rounded', height = 0.8 } } },
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
            'nix',
            'perl',
            'python',
            'svelte',
            'toml',
            'typescript',
            'typescriptreact',
            'zsh',
        },
    },
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        lazy = false,
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            completion = {
                documentation = {
                    auto_show = true,
                    window = {
                        border = 'rounded',
                        winhighlight = blink_completion_winhighlight,
                    },
                },
                list = { selection = { preselect = false } },
                menu = {
                    border = 'rounded',
                    winhighlight = blink_completion_winhighlight,
                },
            },
            keymap = {
                preset = 'enter',
                ['<C-h>'] = { 'snippet_backward', 'fallback' },
                ['<C-l>'] = { 'snippet_forward', 'fallback' },

                ['<C-e>'] = { 'hide_signature', 'hide', 'fallback' },
                ['<C-k>'] = { 'fallback' },
                ['<C-Space>'] = { 'show_signature', 'show' },

                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<Tab>'] = { 'select_next', 'fallback' },
            },
            signature = {
                enabled = true,
                window = {
                    border = 'rounded',
                    winhighlight = blink_completion_winhighlight,
                },
            },
        },
        version = '*',
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
                nix = { 'nixfmt' },
                python = { 'ruff_fix', 'ruff_format' },
                svelte = { 'deno_fmt' },
                toml = { 'taplo' },
                typescript = { 'deno_fmt' },
                typescriptreact = { 'deno_fmt' },
                yaml = { 'deno_fmt' },
                zsh = { 'shfmt' },
            },
        },
    },
}
