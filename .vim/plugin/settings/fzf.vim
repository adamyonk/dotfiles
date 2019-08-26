" Default fzf layout
" - down / up / left / right
" - window (nvim only)
let g:fzf_layout = { 'down': '~15%' }
" let g:fzf_prefer_tmux = 1
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--hidden', <bang>0)

" ripgrep
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)

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

" let $FZF_DEFAULT_OPTS='--layout=reverse'
" let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" function! FloatingFZF()
"   let buf = nvim_create_buf(v:false, v:true)
"   call setbufvar(buf, '&signcolumn', 'no')

"   let height = &lines - 3
"   let width = float2nr(&columns - (&columns * 2 / 10))
"   let col = float2nr((&columns - width) / 2)

"   let opts = {
"         \ 'relative': 'editor',
"         \ 'row': 1,
"         \ 'col': col,
"         \ 'width': width,
"         \ 'height': height
"         \ }

"   call nvim_open_win(buf, v:true, opts)
" endfunction
