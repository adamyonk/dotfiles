"let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_dotfiles = 1
let g:ctrlp_extensions = ['tag']
let g:ctrlp_map = '<leader>.'
let g:ctrlp_max_height = 5
let g:ctrlp_open_new_file = 't' " Open newly created files in a new tab

nnoremap <leader>ja :CtrlP app/assets<cr>
nnoremap <leader>jm :CtrlP app/models<cr>
nnoremap <leader>jv :CtrlP app/views<cr>
nnoremap <leader>jc :CtrlP app/controllers<cr>
nnoremap <leader>jh :CtrlP app/helpers<cr>
