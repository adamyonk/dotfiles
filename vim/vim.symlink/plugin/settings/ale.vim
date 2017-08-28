let g:ale_fix_on_save = 1
let g:ale_fixers = { 'javascript': ['prettier'] }

nnoremap ]r :ALENextWrap<cr>
nnoremap [r :ALEPreviousWrap<cr>
