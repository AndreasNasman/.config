vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.breakindent = true
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.cursorline = true
vim.opt.guicursor:append('a:blinkon100')
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.list = true
vim.opt.listchars = { nbsp = '', tab = '󰌒 ', trail = '󱁐' }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.updatetime = 250

-- Tabs & Spaces
-- http://vimcasts.org/episodes/tabs-and-spaces/
local tab_width_in_spaces = 2
vim.opt.expandtab = false
vim.opt.shiftwidth = tab_width_in_spaces
vim.opt.softtabstop = tab_width_in_spaces
vim.opt.tabstop = tab_width_in_spaces
