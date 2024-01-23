-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local del = vim.keymap.del

-- Reset the behavior of `n` and `N`.
-- https://www.lazyvim.org/configuration/general#keymaps
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
del({ "n" }, "N")
del({ "n" }, "n")
del({ "o" }, "N")
del({ "o" }, "n")
del({ "x" }, "N")
del({ "x" }, "n")

local set = vim.keymap.set

-- stylua: ignore start
-- luacheck: no max line length
set("", "<leader>D", '"_d$', { desc = 'Delete (D) ("_)' })
set("", "<leader>d", '"_d', { desc = 'Delete (d) ("_)' })
set("", "<leader>Y", '"+y$', { desc = 'Copy (Y) ("+)' })
set("", "<leader>y", '"+y', { desc = 'Copy (y) ("+)' })
set("n", "<C-n>", "<cmd>Gitsigns next_hunk<cr>", { desc = "Jump to next hunk" })
set("n", "<C-p>", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Jump to previous hunk" })
set("n", "<leader>+", function() vim.fn.setreg("+", vim.fn.getreg('"')) end, { desc = '"" => "+' })
set("n", "<leader>pa", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, { desc = 'Copy file path (absolute) ("+)' })
set("n", "<leader>pr", function() vim.fn.setreg("+", vim.fn.expand("%:~:.")) end, { desc = 'Copy file path (relative) ("+)' })
set("v", ".", ":normal .<cr>", { desc = "Repeat last change" })
set("v", "<leader>p", '"_c<C-r>"<esc>', { desc = 'Paste ("_)' })
