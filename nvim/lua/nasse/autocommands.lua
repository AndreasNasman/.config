-- https://github.com/tpope/vim-fugitive/issues/2057#issuecomment-1260136745
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit" },
	command = "setlocal spell",
})

-- `:help lua-highlight`
-- https://alpha2phi.medium.com/neovim-for-beginners-lua-autocmd-and-keymap-functions-3bdfe0bebe42#fa3b
vim.api.nvim_create_autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank()",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})
