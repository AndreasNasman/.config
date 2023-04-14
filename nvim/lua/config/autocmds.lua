-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- This autocommand persist cursor blinking in the terminal when quitting Neovim.
-- Configuring `guicursor` in `options.lua` is insufficient.
vim.api.nvim_create_autocmd("VimLeave", {
  command = "set guicursor+=a:blinkon100",
})
