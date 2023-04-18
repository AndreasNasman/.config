-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set

-- stylua: ignore start
set("", "<leader>d", '"_d', { desc = "Delete to the black hole register" })
set("", "<leader>y", '"+y', { desc = "Copy to the system clipboard" })
set("n", "<C-j>", "<cmd>Gitsigns next_hunk<cr>", { desc = "Jump to next hunk." })
set("n", "<C-k>", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Jump to previous hunk." })
set("n", "<leader>+", function() vim.fn.setreg("+", vim.fn.getreg('"')) end, { desc = "Copy the unnamed register value to the system clipboard" })
set("n", "<leader>fpa", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, { desc = "Copy absolute file path to the system clipboard" })
set("n", "<leader>fpr", function() vim.fn.setreg("+", vim.fn.expand("%:~:.")) end, { desc = "Copy relative file path to the system clipboard" })
set("v", ".", ":normal .<cr>", { desc = "Repeat last change in visual mode" })
set("v", "<leader>p", '"_c<C-r>"<ESC>', { desc = "Paste to the black hole register" })
