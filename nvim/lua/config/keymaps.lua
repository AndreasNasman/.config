-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set

-- stylua: ignore start
set("", "<leader>d", '"_d', { desc = 'Delete ("_)' })
set("", "<leader>y", '"+y', { desc = 'Copy (y) ("+)' })
set("", "<leader>Y", '"+Y', { desc = 'Copy (Y) ("+)' })
set("n", "<C-j>", "<cmd>Gitsigns next_hunk<cr>", { desc = "Jump to next hunk" })
set("n", "<C-k>", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Jump to previous hunk" })
set("n", "<leader>+", function() vim.fn.setreg("+", vim.fn.getreg('"')) end, { desc = '"" => "+' })
set("n", "<leader>pa", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, { desc = 'Copy file path (absolute) ("+)' })
set("n", "<leader>pr", function() vim.fn.setreg("+", vim.fn.expand("%:~:.")) end, { desc = 'Copy file path (relative) ("+)' })
set("v", ".", ":normal .<cr>", { desc = "Repeat last change" })
set("v", "<leader>p", '"_c<C-r>"<ESC>', { desc = 'Paste ("_)' })
