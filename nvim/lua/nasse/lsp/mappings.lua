local lsp_leader = "\\"

-- https://github.com/neovim/nvim-lspconfig#suggested-configuration

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { silent = true }
vim.keymap.set("n", lsp_leader .. "e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", lsp_leader .. "l", vim.diagnostic.setloclist, opts)

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
local lsp_formatting = function(bufnr)
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#choosing-a-client-for-formatting
	vim.lsp.buf.format({
		bufnr = bufnr,
		filter = function(client)
			return client.name == "null-ls"
		end,
	})
end

local lsp_formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { silent = true, buffer = bufnr }
	vim.keymap.set("n", lsp_leader .. "D", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", lsp_leader .. "d", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", lsp_leader .. "h", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", lsp_leader .. "i", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", lsp_leader .. "p", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", lsp_leader .. "wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", lsp_leader .. "wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", lsp_leader .. "wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", lsp_leader .. "t", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", lsp_leader .. "R", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", lsp_leader .. "c", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", lsp_leader .. "r", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", lsp_leader .. "f", function()
		lsp_formatting(bufnr)
	end, bufopts)

	-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end

	-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#sync-formatting
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = lsp_formatting_augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = lsp_formatting_augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

return {
	on_attach = on_attach,
}
