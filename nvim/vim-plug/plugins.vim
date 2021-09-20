" Source: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation-of-missing-plugins
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

  " ------
  " Remote
  " ------

  " Embed Neovim in your browser.
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

  " 🌸 A command-line fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  " fzf ❤️ vim
  Plug 'junegunn/fzf.vim'

  " Multiple cursors plugin for vim/neovim
  Plug 'mg979/vim-visual-multi'

  " repeat.vim: enable repeating supported plugin maps with "."
  Plug 'tpope/vim-repeat'

  " surround.vim: quoting/parenthesizing made simple
  Plug 'tpope/vim-surround'


  " -----
  " Local
  " -----

  "🧛 Dark theme for all the things!
  Plug '$XDG_CONFIG_HOME/nvim/plugged/dracula_pro'

call plug#end()

