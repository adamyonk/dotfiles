let g:ale_fix_on_save = 0

let g:ale_fixers = {
      \ 'markdown': ['prettier'],
      \ 'javascript': ['prettier'],
      \ 'json': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'vimwiki': ['prettier']
\}
let g:ale_linters = {
      \ 'jsx': ['stylelint', 'eslint'],
      \ 'typescript': ['tslint']
\}
" \ 'typescript': ['eslint', 'tslint', 'tsserver', 'typecheck']
let g:ale_linter_aliases = { 'jsx': 'css' }
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_javascript_eslint_options = '--ignore-pattern "!.*.js" --no-ignore'

nnoremap <leader>F :ALEFix<cr>
nnoremap ]r :ALENextWrap<cr>
nnoremap [r :ALEPreviousWrap<cr>

autocmd BufRead,BufNewFile,BufWrite {*node_modules*} let g:ale_fix_on_save = 0

