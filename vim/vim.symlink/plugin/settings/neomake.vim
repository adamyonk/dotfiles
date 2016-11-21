" function! ResolveESLint()
"   let l:npm_bin = ''
"   let l:eslint = 'eslint'
"   if executable('npm')
"     let l:npm_bin = split(system('npm bin'), '\n')[0]
"   endif
"   if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
"     let l:eslint = l:npm_bin . '/eslint'
"   endif
"   let b:neomake_javascript_eslint_exe = l:eslint
" endfunction
" autocmd FileType javascript :call ResolveESLint()
" autocmd! BufWritePost,BufReadPost * Neomake
" let g:neomake_javascript_enabled_makers = ['eslint']
" let g:neomake_warning_sign = {
"       \ 'text': 'W',
"       \ 'texthl': 'WarningMsg',
"       \ }
" let g:neomake_error_sign = {
"       \ 'text': 'E',
"       \ 'texthl': 'ErrorMsg',
"       \ }
" let g:neomake_open_list = 2





" if has('nvim')
"   " lots of the below taken from github.com/alexbooker/dotfiles
"   let g:has_local_eslint = 0
"   let g:eslint_executable = 'eslint'

"   function! FindEsLintOnLoad()
"     if g:has_local_eslint == 1
"       return
"     endif

"     let l:npm_bin = ''
"     if executable('npm')
"        let l:npm_bin = split(system('npm bin'), '\n')[0]
"     endif
"     if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
"       let g:has_local_eslint = 1
"       let g:eslint_executable = l:npm_bin . '/eslint'
"     endif
"   endfunction

"   function! ConfigNeoMakeEsLint()
"     call FindEsLintOnLoad()
"     if g:has_local_eslint == 1
"       let g:neomake_javascript_eslint_exe = g:eslint_executable
"       let g:neomake_javascript_enabled_makers = ['eslint']
"       autocmd! BufWritePost *.js Neomake
"     endif
"   endfunction
"   autocmd FileType javascript :call ConfigNeoMakeEsLint()

"   let g:neomake_open_list = 2
" endif

autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = system('PATH=$(npm bin):$PATH && which eslint | tr -d "\n"')
