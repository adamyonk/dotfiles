let g:ale_fix_on_save = 1

let g:ale_fixers = { 'markdown': ['prettier'], 'javascript': ['prettier'], 'vimwiki': ['prettier'] }
let g:ale_linters = { 'jsx': ['stylelint', 'eslint'] }
let g:ale_linter_aliases = { 'jsx': 'css' }
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_javascript_eslint_options = '--no-ignore'

nnoremap ]r :ALENextWrap<cr>
nnoremap [r :ALEPreviousWrap<cr>

autocmd BufRead,BufNewFile,BufWrite {*node_modules*} let g:ale_fix_on_save = 0

