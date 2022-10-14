vim.cmd([[
  colorscheme default
  set clipboard=unnamedplus
  set ignorecase smartcase
  set number relativenumber
  set splitbelow splitright
  set tabstop=2 shiftwidth=2 expandtab
]])

vim.g.mapleader = ' '

vim.api.nvim_set_keymap(
  "n",
  "<Leader>e",
  ":Explore<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>h",
  ":nohlsearch<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>l",
  ":set spell!<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>s",
  ":source $XDG_CONFIG_HOME/nvim/init.lua<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>w",
  ":write<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>oc",
  ":Explore $XDG_CONFIG_HOME<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>os",
  ":edit $XDG_CONFIG_HOME/nvim/init.lua<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader><C-W>f",
  "<C-W>_<C-W>|",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader><C-W><C-F>",
  "<C-W>_<C-W>|",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "x",
  "<Leader>d",
  "\"_d",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "x",
  "<Leader>p",
  "\"_dP",
  { noremap = true }
)

-- Highlight on yank.
-- `:h lua-highlight`
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]

-- Options when commiting in vim-fugitive.
-- https://github.com/tpope/vim-fugitive/issues/2057#issuecomment-1260136745
vim.cmd[[au FileType gitcommit setlocal spell]]

-- packer.nvim
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  use 'kana/vim-textobj-entire' -- Vim plugin: Text objects for entire buffer
  use 'kana/vim-textobj-user' -- Vim plugin: Create your own text objects
  use 'tpope/vim-commentary' -- commentary.vim: comment stuff out
  use 'tpope/vim-fugitive' -- fugitive.vim: A Git wrapper so awesome, it should be illegal
  use 'tpope/vim-repeat' -- repeat.vim: enable repeating supported plugin maps with "."
  use 'tpope/vim-surround' -- surround.vim: quoting/parenthesizing made simple
  use 'tpope/vim-unimpaired' -- unimpaired.vim: Pairs of handy bracket mappings
end)
