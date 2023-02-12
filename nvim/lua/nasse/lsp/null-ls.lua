local null_ls = require("null-ls")
local on_attach = require("nasse.lsp.keymap").on_attach

local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
	on_attach = on_attach,
	sources = {
		code_actions.eslint_d,
		diagnostics.eslint_d,
		diagnostics.luacheck,
		-- formatting.eslint_d,
		formatting.prettierd,
		formatting.stylua,
	},
})
