-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- https://www.reddit.com/r/neovim/comments/10ra30e/comment/j6vi70r/
local function reset_to_default(option)
  opt[option] = vim.api.nvim_get_option_info2(option, {}).default
end

reset_to_default("clipboard")

-- Re-enable the cursor blinking after running a command.
-- `1000` milliseconds is the system default that kitty is configured to use.
opt.guicursor:append("a:blinkon1000")
-- Make completion and documentation menus transparent.
opt.pumblend = 0
