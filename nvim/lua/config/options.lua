-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- `:help clipboard-wsl`
vim.g.clipboard = {
  cache_enabled = 0,
  copy = {
    ["*"] = "clip.exe",
    ["+"] = "clip.exe",
  },
  name = "WslClipboard",
  paste = {
    ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
}

-- https://www.reddit.com/r/neovim/comments/10ra30e/comment/j6vi70r/
local function reset_to_default(accessor, option)
  accessor[option] = vim.api.nvim_get_option_info2(option, {}).default
end

local opt = vim.opt

reset_to_default(opt, "clipboard") -- Separate Neovim and system clipboards.
opt.guicursor:append("a:blinkon100") -- Blink cursor to match terminal settings.
opt.pumblend = 0 -- Disable popup menu transparency.

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
