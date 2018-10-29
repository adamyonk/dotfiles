let g:tsuquyomi_disable_quickfix = 1
autocmd FileType typescript nmap <buffer> <leader>t : <c-u>echo tsuquyomi#hint()<cr>
