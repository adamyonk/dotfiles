" Insert Mode
inoremap jk <esc>

" Toggle "keep current line centered" mode
nnoremap <leader>C :let &scrolloff=999-&scrolloff<cr>

" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Yank from cursor to end of line
nnoremap Y y$

" Move across wrapped lines better
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" redraw!
nnoremap <leader>rr :redraw!<cr>

" ctags
set tags=tags;/
command! ReloadTags :!/usr/local/bin/ctags --tag-relative -ftags --extra=+f --exclude=.git --exclude=doc --exclude=coverage -R<cr>
command! GitTags :!.git/hooks/ctags<cr>

" Wrap selection
vmap <leader>" c"<C-R>""<esc>
vmap <leader>' c'<C-R>"'<esc>
vmap <leader># c#{<C-R>"}<esc>
vmap <leader>( c(<C-R>")<esc>
vmap <leader>[ c[<C-R>"]<esc>
