" ------
" Config
" ------

let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'ignoreKeys': {
            \ 'insert': ['<D-v>'],
            \ 'normal': ['<D-1>', '<D-2>', '<D-3>', '<D-4>', '<D-5>', '<D-6>', '<D-7>', '<D-8>', '<D-9>'],
        \ }
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'takeover': 'never',
        \ },
    \ }
\ }


" -------
" Options
" -------

"
" General
"

set guifont=JetBrainsMono_Nerd_Font_Mono:h20
set linebreak
set wrap


" -----
" Other
" -----

"
" Automatically syncing changes to the page
" Source : https://github.com/glacambre/firenvim#automatically-syncing-changes-to-the-page
"

let g:dont_write = v:false
function! My_Write(timer) abort
  let g:dont_write = v:false
  write
endfunction

function! Delay_My_Write() abort
  if g:dont_write
    return
  end
  let g:dont_write = v:true
  let l:delay = 5000
  call timer_start(l:delay, 'My_Write')
endfunction

au TextChanged * ++nested call Delay_My_Write()
au TextChangedI * ++nested call Delay_My_Write()

"
" Fullscreen toggle
"

nnoremap <leader>f :call FullscreenToggle()<CR>

let g:in_fullscreen = v:false
function! FullscreenToggle()
    if g:in_fullscreen
        set columns=78
        set lines=9
        let g:in_fullscreen = v:false
    else
        set columns=999
        set lines=999
        let g:in_fullscreen = v:true
    endif
endfunction

