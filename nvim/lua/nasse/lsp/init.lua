-- https://github.com/williamboman/mason-lspconfig.nvim#setup
require("mason").setup()
require("mason-lspconfig").setup({
	-- https://github.com/williamboman/mason-lspconfig.nvim#default-configuration
	ensure_installed = { "sumneko_lua", "tsserver" },
})

-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = require("nasse.lsp.mappings").on_attach

-- `:help mason-lspconfig.setup_handlers()`
local lspconfig = require("lspconfig")
local config = {
	capabilities = capabilities,
	on_attach = on_attach,
}

require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup(config)
	end,

	["sumneko_lua"] = function()
		lspconfig.sumneko_lua.setup(vim.tbl_deep_extend("force", config, {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					runtime = {
						version = _VERSION, -- Downgrade the Lua version of `sumneko_lua` (currently 5.4) to Neovim's (currently 5.1). This fixes e.g. deprecation warnings.
					},
				},
			},
		}))
	end,
})
