local lsp_leader = "\\"

local set = vim.keymap.set
local opts = { silent = true }

-- stylua: ignore start
-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
set("n", lsp_leader .. "v", vim.diagnostic.open_float, opts)
set("n", "[v", vim.diagnostic.goto_prev, opts)
set("n", "]v", vim.diagnostic.goto_next, opts)
set("n", lsp_leader .. "l", vim.diagnostic.setloclist, opts)
-- stylua: ignore end

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

local builtin = require("telescope.builtin")
local lsp_formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local gitsigns = require("gitsigns")

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local bufopts = { silent = true, buffer = bufnr }
-- stylua: ignore start
	set("n", lsp_leader .. "D", vim.lsp.buf.declaration, bufopts)
	set("n", lsp_leader .. "d", builtin.lsp_definitions, bufopts)
	set("n", lsp_leader .. "h", vim.lsp.buf.hover, bufopts)
	set("n", lsp_leader .. "i", builtin.lsp_implementations, bufopts)
	set("n", lsp_leader .. "p", vim.lsp.buf.signature_help, bufopts)
	set("n", lsp_leader .. "wa", vim.lsp.buf.add_workspace_folder, bufopts)
	set("n", lsp_leader .. "wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	set("n", lsp_leader .. "wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
	set("n", lsp_leader .. "t", builtin.lsp_type_definitions, bufopts)
	set("n", lsp_leader .. "R", vim.lsp.buf.rename, bufopts)
	set("n", lsp_leader .. "c", vim.lsp.buf.code_action, bufopts)
	set("n", lsp_leader .. "r", builtin.lsp_references, bufopts)
	set("n", lsp_leader .. "f", function() lsp_formatting(bufnr) end, bufopts)

	set("n", "<Leader>j", gitsigns.next_hunk, bufopts)
	set("n", "<Leader>k", gitsigns.prev_hunk, bufopts)
	-- stylua: ignore end

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
