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
