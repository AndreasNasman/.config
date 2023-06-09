-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- https://www.reddit.com/r/neovim/comments/10ra30e/comment/j6vi70r/
local function reset_to_default(accessor, option)
  accessor[option] = vim.api.nvim_get_option_info2(option, {}).default
end

local opt = vim.opt

reset_to_default(opt, "clipboard") -- Separate Neovim and system clipboards.
opt.fillchars:append("eob: ") -- Hide ~ at end of buffer.
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

-- The approach mentioned in `:help clipboard-wsl` does not work with unicode characters.
-- This implementation using `wl-clipboard` works as expected.
-- https://stackoverflow.com/a/76388417
vim.g.clipboard = {
  cache_enabled = true,
  copy = {
    ["+"] = "wl-copy --foreground --type text/plain",
    ["*"] = "wl-copy --foreground --primary --type text/plain",
  },
  name = "wl-clipboard (wsl)",
  paste = {
    ["+"] = function()
      return vim.fn.systemlist('wl-paste --no-newline|sed -e "s/\r$//"', { "" }, 1) -- '1' keeps empty lines
    end,
    ["*"] = function()
      return vim.fn.systemlist('wl-paste --primary --no-newline|sed -e "s/\r$//"', { "" }, 1)
    end,
  },
}
