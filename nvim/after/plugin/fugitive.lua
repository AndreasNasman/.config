local set = vim.keymap.set

set("n", "<Leader>g", vim.cmd.Git)

-- https://github.com/tpope/vim-fugitive/issues/2057#issuecomment-1260136745
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit" },
	command = "setlocal spell",
})
