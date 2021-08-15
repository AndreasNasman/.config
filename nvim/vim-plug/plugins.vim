" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation-of-missing-plugins
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
  " Embed Neovim in your browser.
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
  " repeat.vim: enable repeating supported plugin maps with "."
  Plug 'tpope/vim-repeat'
  " surround.vim: quoting/parenthesizing made simple
  Plug 'tpope/vim-surround'
call plug#end()

