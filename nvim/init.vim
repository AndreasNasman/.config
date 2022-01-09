" -------
" Plugins
" -------

source $XDG_CONFIG_HOME/nvim/vim-plug/plugins.vim


" -------
" Options
" -------

"
" Lua
"

au TextYankPost * silent! lua vim.highlight.on_yank()

"
" General
"

set clipboard=unnamed " Sync NeoVim and system clipboards (register `"*` on macOS).
set confirm           " Raise a dialogue asking if you wish to e.g. save changed files.
set ignorecase        " Use case insensitive search.
set incsearch         " Incrementally match searches.
set noshowmode        " Disable showing mode message, `vim-airline` plugin handles it.
set nowrap            " Disable wrapping of text.
set number            " Display line numbers.
set relativenumber    " Display relative line numbers.
set report=0          " Always show reporting number of lines changed.
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

"
" Language
"

" Currently, language is not properly set to `en_US` unless you explicitly set it.
language en_US.UTF-8

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

nnoremap <Leader>h :nohlsearch<CR>
nnoremap <Leader>os :Sexplore<CR>
nnoremap <Leader>ov :Vexplore<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>so :so $XDG_CONFIG_HOME/nvim/init.vim<CR>

map Y y$


" -----
" Other
" -----

"
" Firenvim
"

if exists("g:started_by_firenvim")
  source $XDG_CONFIG_HOME/nvim/firenvim/firenvim.vim
endif

"
" vim-airline
"

let g:airline_powerline_fonts = 1

"
" EasyMotion
"

" Coloring.
hi link EasyMotionTarget Search
hi link EasyMotionShade None
hi link EasyMotionTarget2First ErrorMsg
hi link EasyMotionTarget2Second ErrorMsg

" Remaps.
" nmap <C-;> <Plug>(easymotion-s) " Mapping `<C-;>` doesn't work.

