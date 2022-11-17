-- https://github.com/williamboman/mason-lspconfig.nvim#setup
require("mason").setup({
	ui = {
		border = "single",
	},
})
require("mason-lspconfig").setup({
	-- https://github.com/williamboman/mason-lspconfig.nvim#default-configuration
	ensure_installed = { "sumneko_lua", "tsserver" },
})

-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
local lspconfig = require("lspconfig")
require("lspconfig.ui.windows").default_options.border = "single"

local config = {
	-- Add additional capabilities supported by nvim-cmp
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = require("nasse.lsp.mappings").on_attach,
}

-- `:help mason-lspconfig.setup_handlers()`
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

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.luacheck,
	},
})
