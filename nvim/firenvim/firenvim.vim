" Source : https://github.com/glacambre/firenvim#automatically-syncing-changes-to-the-page
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
  call timer_start(10000, 'My_Write')
endfunction

au TextChanged * ++nested call Delay_My_Write()
au TextChangedI * ++nested call Delay_My_Write()

