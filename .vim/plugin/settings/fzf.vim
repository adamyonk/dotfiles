" Default fzf layout
" - down / up / left / right
" - window (nvim only)
let g:fzf_layout = { 'down': '~15%' }
" let g:fzf_prefer_tmux = 1
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--hidden', <bang>0)

" ripgrep
" Don't search filenames:
command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --auto-hybrid-regex --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
  \   1,
  \   {'options': '--delimiter : --nth 2..'})

nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>l :Lines<cr>
nnoremap <leader>a :Rg<cr>

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

if has('nvim')
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif
