local set = vim.keymap.set
local silent = { silent = true }

vim.g.mapleader = " "

-- 2. Normal mode.

-- Convenience.
set("n", "<Leader>e", ":Explore<CR>", silent)
set("n", "<Leader>s", ":write<CR>")

-- Toggle options.
set("n", "<Leader>l", ":set spell!<CR>", silent)

-- Edit config files.
set("n", "<Leader>oc", ":Explore $XDG_CONFIG_HOME<CR>", silent)
set("n", "<Leader>os", ":edit $XDG_CONFIG_HOME/nvim/lua/nasse/options.lua<CR>", silent)

-- Full screen window.
set("n", "<Leader><C-w><C-f>", "<C-w>_<C-w>|")
set("n", "<Leader><C-w>f", "<C-w>_<C-w>|")

-- 3. Visual mode.

-- Void delete and paste.
set("v", "<Leader>d", '"_d')
set("v", "<Leader>p", '"_c<C-r>+<ESC>')
