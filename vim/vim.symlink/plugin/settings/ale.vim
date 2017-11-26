let g:ale_fix_on_save = 1
let g:ale_fixers = { 'markdown': ['prettier'], 'javascript': ['prettier'] }
let g:ale_linters = { 'jsx': ['stylelint', 'eslint'] }
let g:ale_linter_aliases = { 'jsx': 'css' }
let g:ale_javascript_prettier_use_local_config = 1

nnoremap ]r :ALENextWrap<cr>
nnoremap [r :ALEPreviousWrap<cr>
