vim.g.mapleader = " "

local set = vim.keymap.set
local opts = { silent = true }

local function fullscreen_window()
	vim.cmd("resize | vertical resize")
end

-- stylua: ignore start

-- Overrides that keep the cursor in the middle of the screen.
set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half a screen and with the cursor in the middle of the screen" })
set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half a screen and with the cursor in the middle of the screen" })
set("n", "G", "Gzz", { desc = "Go to the last line with the cursor in the middle of the screen" })
set("n", "n", "nzz", { desc = "Repeat the latest search with the cursor in the middle of the screen" })
set("n", "N", "Nzz", { desc = "Repeat the latest search in the opposite direction with the cursor in the middle of the screen" })

-- Essentials.
set("n", "<Leader>/", "/\\v", { desc = "Search using very magic" })
set("n", "<Leader><C-w><C-f>", fullscreen_window, { desc = "Fullscreen window" })
set("n", "<Leader><C-w>f", fullscreen_window, { desc = "Fullscreen window" })
set("n", "<Leader>e", vim.cmd.Explore, vim.tbl_deep_extend("force", opts, { desc = "Explore directory of current file" }))
set("n", "<Leader>l", function() vim.cmd.set("spell!") end, opts, { desc = "Toggle spell checking" })
set("n", "<Leader>oc", function() vim.cmd.Explore("$XDG_CONFIG_HOME") end, vim.tbl_deep_extend("force", opts, { desc = "Open .config directory" }))
set("n", "<Leader>s", vim.cmd.write, { desc = "Save current buffer" })
-- Doesn't seem possible to write with with `vim.cmd.normal`.
set("v", ".", ':normal .<CR>', { desc = "Repeat the dot command over visual selection" })

-- Register utilities.
set("", "<Leader>d", '"_d', { desc = "Delete to black hole register" })
set("", "<Leader>y", '"+y', { desc = "Copy to the plus register" })
set("n", "<Leader>+", function() vim.fn.setreg("+", vim.fn.getreg('"')) end, opt, { desc = 'Copy value from " to the + register' })
set("n", "<Leader>Y", '"+Y', { desc = "Copy trailing line to the plus register" })
set("v", "<Leader>p", '"_c<C-r>"<ESC>', { desc = "Paste to black hole register" })

-- stylua: ignore end
