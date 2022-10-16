local options = {
  clipboard = "unnamedplus",
  expandtab = true,
  ignorecase = true,
  number = true,
  relativenumber = true,
  shiftwidth = 2,
  smartcase = true,
  splitbelow = true,
  splitright = true,
  tabstop = 2,
}

for key, value in pairs(options) do
  vim.opt[key] = value
end
