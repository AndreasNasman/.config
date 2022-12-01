local set = vim.keymap.set
local silent = { silent = true }

vim.g.mapleader = " "

set(
	"n",
	"<Leader>e",
	":Explore<CR>",
	vim.tbl_deep_extend("force", silent, { desc = "Explore directory of current file" })
)
set("n", "<Leader>s", ":write<CR>", { desc = "Save current buffer" })
set("n", "<Leader>l", ":set spell!<CR>", silent, { desc = "Toggle spell checking" })
set(
	"n",
	"<Leader>oc",
	":Explore $XDG_CONFIG_HOME<CR>",
	vim.tbl_deep_extend("force", silent, { desc = "Open .config directory" })
)
set(
	"n",
	"<Leader>os",
	":edit $XDG_CONFIG_HOME/nvim/lua/nasse/options.lua<CR>",
	vim.tbl_deep_extend("force", silent, { desc = "Edit Neovim options" })
)
set("n", "<Leader><C-w><C-f>", "<C-w>_<C-w>|", { desc = "Fullscreen window" })
set("n", "<Leader><C-w>f", "<C-w>_<C-w>|", { desc = "Fullscreen window" })
set("v", "<Leader>d", '"_d', { desc = "Void delete" })
set("v", "<Leader>p", '"_c<C-r>+<ESC>', { desc = "Void paste" })
