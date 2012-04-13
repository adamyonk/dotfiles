" Insert Mode
inoremap jk <esc>

" Toggle "keep current line centered" mode
nnoremap <leader>C :let &scrolloff=999-&scrolloff<cr>

" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Move across wrapped lines better
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" redraw!
nnoremap <leader>rr :redraw!<cr>
