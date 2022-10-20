require('nasse.options')
require('nasse.keymaps')

vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('W', 'write', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})


-- Highlight on yank.
-- `:h lua-highlight`
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]

-- Options when commiting in vim-fugitive.
-- https://github.com/tpope/vim-fugitive/issues/2057#issuecomment-1260136745
vim.cmd[[au FileType gitcommit setlocal spell]]

-- firenvim
vim.g.firenvim_config = {
  localSettings = {
    [".*"] = {
      takeover = "never"
    }
  }
}

-- packer.nvim
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end } -- Embed Neovim in Chrome, Firefox, Thunderbird and many other pieces of software.
  use 'kana/vim-textobj-entire' -- Vim plugin: Text objects for entire buffer
  use 'kana/vim-textobj-user' -- Vim plugin: Create your own text objects
  use 'tpope/vim-commentary' -- commentary.vim: comment stuff out
  use 'tpope/vim-fugitive' -- fugitive.vim: A Git wrapper so awesome, it should be illegal
  use 'tpope/vim-repeat' -- repeat.vim: enable repeating supported plugin maps with "."
  use 'tpope/vim-surround' -- surround.vim: quoting/parenthesizing made simple
  use 'tpope/vim-unimpaired' -- unimpaired.vim: Pairs of handy bracket mappings
end)
