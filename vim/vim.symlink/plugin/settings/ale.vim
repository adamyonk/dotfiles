let g:ale_fix_on_save = 1
let g:ale_fixers = { 'javascript': ['prettier'] }
let g:ale_javascript_prettier_use_local_config = 1

nnoremap ]r :ALENextWrap<cr>
nnoremap [r :ALEPreviousWrap<cr>
