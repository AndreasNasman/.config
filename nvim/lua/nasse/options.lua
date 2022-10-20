local options = {
  clipboard = "unnamedplus",
  cursorline = true,
  expandtab = true,
  ignorecase = true,
  number = true,
  relativenumber = true,
  shiftwidth = 2,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  tabstop = 2,
  undofile = true,
  wrap = false,
}

for key, value in pairs(options) do
  vim.opt[key] = value
end
