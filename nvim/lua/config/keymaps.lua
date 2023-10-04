-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- https://www.lazyvim.org/configuration/general#keymaps
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

if Util.has("bufferline.nvim") then
  map("n", "<leader>bb", "<cmd>BufferLinePick<cr>", { desc = "Focus buffer" })
  map("n", "<leader>bo", "<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>", { desc = "Close other buffers" })
end

-- stylua: ignore start
map("", "<leader>Y", '"+y$', { desc = 'Copy (Y) ("+)' })
map("", "<leader>d", '"_d', { desc = 'Delete ("_)' })
map("", "<leader>y", '"+y', { desc = 'Copy (y) ("+)' })
map("n", "<S-C-j>", "<cmd>Gitsigns next_hunk<cr>", { desc = "Jump to next hunk" }) -- Override
map("n", "<S-C-k>", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Jump to previous hunk" }) -- Override
map("n", "<leader>+", function() vim.fn.setreg("+", vim.fn.getreg('"')) end, { desc = '"" => "+' })
map("n", "<leader>pa", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, { desc = 'Copy file path (absolute) ("+)' })
map("n", "<leader>pr", function() vim.fn.setreg("+", vim.fn.expand("%:~:.")) end, { desc = 'Copy file path (relative) ("+)' })
map("v", ".", ":normal .<cr>", { desc = "Repeat last change" })
map("v", "<leader>p", '"_c<C-r>"<esc>', { desc = 'Paste ("_)' })
