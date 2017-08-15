let g:ale_fix_on_save = 1
let g:ale_fixers = { 'javascript': ['prettier'] }
let g:ale_javascript_prettier_options = '--no-semi --trailing-comma es5'

nnoremap ]r :ALENextWrap<cr>
nnoremap [r :ALEPreviousWrap<cr>
