local utils = require('utils')

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
                    if vim.bo.modifiable then
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

                    buffer_map('<C-k>', vim.lsp.buf.signature_help, { 'n', 'x' })
                    buffer_map('<Leader>la', vim.lsp.buf.code_action, { 'n', 'x' })
                    buffer_map('<Leader>ld', require('telescope.builtin').lsp_document_symbols)
                    buffer_map('<Leader>lr', vim.lsp.buf.rename)
                    buffer_map('<Leader>lt', require('telescope.builtin').lsp_type_definitions)
                    buffer_map('<Leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols)
                    buffer_map('gd', require('telescope.builtin').lsp_definitions)
                    buffer_map('gD', vim.lsp.buf.declaration)
                    buffer_map('gI', require('telescope.builtin').lsp_implementations)
                    buffer_map('gr', require('telescope.builtin').lsp_references)
                    buffer_map('K', vim.lsp.buf.hover)

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
                ['nil'] = {},
                cssls = {},
                denols = {},
                emmet_language_server = {},
                html = {},
                jsonls = {},
                lua_ls = { settings = { Lua = { hint = { enable = true } } } },
                markdownlint = {},
                marksman = {},
                pyright = {},
                ruff = {},
                shfmt = {},
                stylua = {},
                svelte = {},
                tailwindcss = {},
                taplo = {},
            }
            require('mason-tool-installer').setup({ ensure_installed = vim.tbl_keys(servers) })

            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require('mason-lspconfig').setup({
                automatic_installation = false,
                ensure_installed = {},
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
            { 'j-hui/fidget.nvim', opts = {} },
            { 'mason-org/mason-lspconfig.nvim' },
            { 'mason-org/mason.nvim', opts = { ui = { border = 'none' } } },
            { 'saghen/blink.cmp' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
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
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                build = 'make install_jsregexp',
                dependencies = {
                    'rafamadriz/friendly-snippets',
                    config = function()
                        require('luasnip.loaders.from_vscode').lazy_load()
                    end,
                },
            },
        },
        event = 'UIEnter',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            completion = {
                documentation = { auto_show = true },
                list = { selection = { preselect = false } },
                menu = { winhighlight = 'Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None' },
            },
            keymap = {
                preset = 'enter',
                ['<C-h>'] = { 'snippet_backward', 'fallback' },
                ['<C-l>'] = { 'snippet_forward', 'fallback' },

                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<Tab>'] = { 'select_next', 'fallback' },
            },
            signature = { enabled = true },
            snippets = { preset = 'luasnip' },
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = { lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 } },
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
