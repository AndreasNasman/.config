" -------
" Plugins
" -------

"
" Dracula Pro
"

packadd! dracula_pro
let g:dracula_colorterm = 0
colorscheme dracula_pro

if !exists('g:started_by_firenvim')
  source $XDG_CONFIG_HOME/nvim/vim-plug/plugins.vim
endif

" -------
" Options
" -------

set clipboard=unnamed	" Sync NeoVim's wth system clipboard, register `"*` on macOS.
set confirm		" Raise a dialogue asking if you wish to e.g. save changed files.
set ignorecase		" Use case insensitive search.
set incsearch		" Incrementally match searches.
set nowrap		" Disable wrapping of text.
set number		" Display line numbers.
set relativenumber	" Display relative line numbers.
set smartcase		" Match capitalized word exactly when searching.

" --------
" Mappings
" --------

let mapleader = " "

" ----------
" Remappings
" ----------

map Y y$

