require("nasse.options")
require("nasse.keymaps")
require("nasse.plugins")
require("nasse.colorscheme")
require("nasse.cmp")
require("nasse.commands")

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
