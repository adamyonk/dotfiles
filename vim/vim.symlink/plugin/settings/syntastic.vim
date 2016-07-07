" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_javascript_eslint_exec = system('npm bin | tr -d "\n"') . "/eslint"
