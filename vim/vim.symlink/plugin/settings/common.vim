" Insert Mode
inoremap jk <esc>

" Toggle "keep current line centered" mode
nnoremap <leader>C :let &scrolloff=999-&scrolloff<cr>

" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Keep cursor in place when joining lines
nnoremap J mzJ`z

" Yank from cursor to end of line
nnoremap Y y$

" Move across wrapped lines better
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Faster colon
nnoremap ; :
vnoremap ; :

" Wrap current paragraph
nnoremap <leader>wp gqip

" Split window navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" redraw!
nnoremap <leader>rr :redraw!<cr>

" ctags
set tags=tags;/
command! ReloadTags :!/usr/local/bin/ctags --tag-relative -ftags --extra=+f --exclude=.git --exclude=doc --exclude=coverage -R<cr>
command! GitTags :!.git/hooks/ctags<cr>

" sudo write
command W w !sudo tee % > /dev/null

" Wrap selection
vmap <leader>" c"<C-R>""<esc>
vmap <leader>' c'<C-R>"'<esc>
vmap <leader># c#{<C-R>"}<esc>
vmap <leader>( c(<C-R>")<esc>
vmap <leader>[ c[<C-R>"]<esc>
