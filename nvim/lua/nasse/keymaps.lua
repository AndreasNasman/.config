local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

-- 2. Normal mode.

-- Convenience.
keymap("n", "<Leader>e", ":Explore<CR>", opts)
keymap("n", "<Leader>s", ":source $XDG_CONFIG_HOME/nvim/lua/nasse/options.lua<CR>", opts)
keymap("n", "<Leader>w", ":write<CR>", opts)

-- Toggle options.
keymap("n", "<Leader>h", ":nohlsearch<CR>", opts)
keymap("n", "<Leader>l", ":set spell!<CR>", opts)

-- Edit config files.
keymap("n", "<Leader>oc", ":Explore $XDG_CONFIG_HOME<CR>", opts)
keymap("n", "<Leader>os", ":edit $XDG_CONFIG_HOME/nvim/lua/nasse/options.lua<CR>", opts)

-- Full screen window.
keymap("n", "<Leader><C-w><C-f>", "<C-w>_<C-w>|", opts)
keymap("n", "<Leader><C-w>f", "<C-w>_<C-w>|", opts)

-- 3. Visual mode.

-- Void delete and paste.
keymap("v", "<Leader>d", "\"_d", opts)
keymap("v", "<Leader>p", "\"_c<C-r>+<ESC>", opts)
