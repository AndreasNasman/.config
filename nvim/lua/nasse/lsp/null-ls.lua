local null_ls = require("null-ls")
local on_attach = require("nasse.lsp.mappings").on_attach

null_ls.setup({
	on_attach = on_attach,
	sources = {
		null_ls.builtins.diagnostics.luacheck,
		null_ls.builtins.formatting.stylua,
	},
})
