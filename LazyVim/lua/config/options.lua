-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Re-enable the cursor blinking after running a command.
-- `1000` milliseconds is the system default that kitty is configured to use.
opt.guicursor:append("a:blinkon1000")
-- Make completion and documentation menus transparent.
opt.pumblend = 0
