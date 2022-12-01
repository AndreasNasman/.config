-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/#vim-opt
vim.cmd([[colorscheme tokyonight-night]])

local set = vim.opt

set.clipboard = "unnamedplus"
-- https://github.com/hrsh7th/nvim-cmp#recommended-configuration
set.completeopt = "menu,menuone,noselect"
set.cursorline = true
set.expandtab = true
set.ignorecase = true
set.number = true
set.relativenumber = true
set.shiftwidth = 2
set.signcolumn = "yes"
set.smartcase = true
set.smartindent = true
set.splitbelow = true
set.splitright = true
set.tabstop = 2
set.termguicolors = true
set.undofile = true
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor
-- `250` seems like a common low functioning value for `updatetime`.
-- Lowering it causes problems when running e.g. `ReloadConfig`.
set.updatetime = 300
set.wrap = false
