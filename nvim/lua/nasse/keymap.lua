vim.g.mapleader = " "

local set = vim.keymap.set
local opts = { silent = true }

local function fullscreen_window()
	vim.cmd("resize | vertical resize")
end

-- stylua: ignore start

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

-- Overrides that keep the cursor in the middle of the screen.
set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half a screen and with the cursor in the middle of the screen" })
set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half a screen and with the cursor in the middle of the screen" })
set("n", "G", "Gzz", { desc = "Go to the last line with the cursor in the middle of the screen" })
set("n", "n", "nzz", { desc = "Repeat the latest search with the cursor in the middle of the screen" })
set("n", "N", "Nzz", { desc = "Repeat the latest search in the opposite direction with the cursor in the middle of the screen" })

-- Register utilities.
set("", "<Leader><Leader>", '"+', { desc = "Prompt the plus register" })
set("", "<Leader>d", '"_d', { desc = "Delete to black hole register" })
set("n", "<Leader>+", function() vim.fn.setreg("+", vim.fn.getreg('"')) end, opt, { desc = 'Copy value from " to the + register' })
set("v", "<Leader>p", '"_c<C-r>"<ESC>', { desc = "Paste to black hole register" })

-- Plugins.
set("n", "<Leader>g", vim.cmd.Git)
set("n", "<Leader>u", vim.cmd.UndotreeToggle)

local builtin = require("telescope.builtin")
set("n", "<Leader>fb", builtin.buffers, { desc = "Lists open buffers in current neovim instance, opens selected buffer on `<cr>`" })
set("n", "<Leader>fd", builtin.lsp_document_symbols, { desc = "Lists git status for current directory" })
set("n", "<Leader>ff", builtin.find_files, { desc = "Search for files (respecting .gitignore)" })
set("n", "<Leader>fg", builtin.git_status, { desc = "Lists git status for current directory" })
set("n", "<Leader>fh", builtin.help_tags, { desc = "Lists available help tags and opens a new window with the relevant help info on `<cr>`" })
set("n", "<Leader>fm", builtin.man_pages, { desc = "Lists manpage entries, opens them in a help window on `<cr>`" })
set("n", "<Leader>fo", builtin.oldfiles, { desc = "Lists previously open files, opens on `<cr>`" })
set("n", "<Leader>fs", builtin.live_grep, { desc = "Search for a string and get results live as you type, respects .gitignore" })

-- stylua: ignore end
