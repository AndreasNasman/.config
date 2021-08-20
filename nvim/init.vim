" -------
" Plugins
" -------

source ~/.config/nvim/vim-plug/plugins.vim



" -------
" Options
" -------

"
" General
"

set clipboard=unnamed " Sync NeoVim and system clipboards (register `"*` on macOS).
set confirm           " Raise a dialogue asking if you wish to e.g. save changed files.
set ignorecase        " Use case insensitive search.
set incsearch         " Incrementally match searches.
set nowrap            " Disable wrapping of text.
set number            " Display line numbers.
set relativenumber    " Display relative line numbers.
set smartcase         " Match capitalized word exactly when searching.
set smartindent       " Enable smart auto indenting on new lines.

"
" Color scheme
"

"let g:dracula_colorterm = 0 " Remove gray overlay present in the Dracula Pro theme.
set termguicolors            " Use GUI-based colors in the terminal (also removes Dracula Pro theme gray overlay).
colorscheme dracula_pro

"
" Tabs vs. spaces
"

set expandtab             " Use space characters instead of tabs.
let spaces = 2
let &shiftwidth = spaces  " Set how many spaces an (auto)indent is.
let &softtabstop = spaces " Fine tune amount of white space to insert and delete when using <BS>.
let &tabstop = spaces     " Set whitespace width of a tab character.


" --------
" Mappings
" --------

"
" Leader
"

let leader    = "\<Space>"
let mapleader = leader

"
" vim-visual-multi
"

let g:VM_leader                     = "<Leader><Leader>"

let g:VM_maps                       = {}
let g:VM_maps["Add Cursor Down"]    = '<C-j>'
let g:VM_maps["Add Cursor Up"]      = '<C-k>'
let g:VM_maps["Select Cursor Down"] = '<M-C-j>'
let g:VM_maps["Select Cursor Up"]   = '<M-C-k>'


" ----------
" Remappings
" ----------

map Y y$


" -----
" Other
" -----

"
" Firenvim
"

if exists("g:started_by_firenvim")
  source ~/.config/nvim/firenvim/firenvim.vim
endif

