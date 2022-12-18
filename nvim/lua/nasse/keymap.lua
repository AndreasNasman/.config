vim.g.mapleader = " "

local set = vim.keymap.set
local opts = { silent = true }

local function fullscreen_window()
	vim.cmd("resize | vertical resize")
end

set("n", "<Leader>/", "/\\v", { desc = "Search using very magic" })
set("n", "<Leader><C-w><C-f>", fullscreen_window, { desc = "Fullscreen window" })
set("n", "<Leader><C-w>f", fullscreen_window, { desc = "Fullscreen window" })
set(
	"n",
	"<Leader>e",
	vim.cmd.Explore,
	vim.tbl_deep_extend("force", opts, { desc = "Explore directory of current file" })
)
set("n", "<Leader>l", function()
	vim.cmd.set("spell!")
end, opts, { desc = "Toggle spell checking" })
set("n", "<Leader>oc", function()
	vim.cmd.Explore("$XDG_CONFIG_HOME")
end, vim.tbl_deep_extend("force", opts, { desc = "Open .config directory" }))
set("n", "<Leader>s", vim.cmd.write, { desc = "Save current buffer" })
set("v", "<Leader>d", '"_d', { desc = "Delete to black hole register" })
set("v", "<Leader>p", '"_c<C-r>+<ESC>', { desc = "Paste to black hole register" })
