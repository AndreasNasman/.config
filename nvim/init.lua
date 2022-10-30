require("nasse.options")
require("nasse.keymaps")
require("nasse.plugins")
require("nasse.colorscheme")
require("nasse.cmp")

vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("W", "write", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})

-- Highlight on yank.
-- `:h lua-highlight`
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])

-- Options when commiting in vim-fugitive.
-- https://github.com/tpope/vim-fugitive/issues/2057#issuecomment-1260136745
vim.cmd([[au FileType gitcommit setlocal spell]])

-- firenvim
vim.g.firenvim_config = {
	localSettings = {
		[".*"] = {
			takeover = "never",
		},
	},
}
