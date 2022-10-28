-- https://github.com/wbthomason/packer.nvim#quickstart
-- `PackerSync` fits my use cases better than `PackerCompile`.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- A use-package inspired plugin manager for Neovim. Uses native packages, supports Luarocks dependencies, written in Lua, allows for expressive config.

  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end } -- Embed Neovim in Chrome, Firefox, Thunderbird and many other pieces of software.
  use 'kana/vim-textobj-entire' -- Vim plugin: Text objects for entire buffer
  use 'kana/vim-textobj-user' -- Vim plugin: Create your own text objects
  use 'tpope/vim-commentary' -- commentary.vim: comment stuff out
  use 'tpope/vim-fugitive' -- fugitive.vim: A Git wrapper so awesome, it should be illegal
  use 'tpope/vim-repeat' -- repeat.vim: enable repeating supported plugin maps with "."
  use 'tpope/vim-surround' -- surround.vim: quoting/parenthesizing made simple
  use 'tpope/vim-unimpaired' -- unimpaired.vim: Pairs of handy bracket mappings
end)
