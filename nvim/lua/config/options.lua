-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- https://www.reddit.com/r/neovim/comments/10ra30e/comment/j6vi70r/
local function reset_to_default(accessor, option)
  accessor[option] = vim.api.nvim_get_option_info2(option, {}).default
end

local opt = vim.opt

reset_to_default(opt, "clipboard") -- Separate Neovim and system clipboards.

local api = vim.api

-- Case-insensitive versions of common commands.
api.nvim_create_user_command("Q", "quit", {})

api.nvim_create_user_command("QA", "qall", {})
api.nvim_create_user_command("Qa", "qall", {})

api.nvim_create_user_command("W", "write", {})

api.nvim_create_user_command("WA", "wall", {})
api.nvim_create_user_command("Wa", "wall", {})

api.nvim_create_user_command("WQ", "wq", {})
api.nvim_create_user_command("Wq", "wq", {})

-- Add border to line diagnostics.
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#borders
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
