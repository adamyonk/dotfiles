nnoremap ]s :Switch<cr>
nnoremap [s :SwitchReverse<cr>
" let g:switch_custom_definitions =
"   \ [
"   \   ['true', 'false']
"   \ ]

autocmd FileType {javascript,typescript} let b:switch_custom_definitions =
  \ [
  \   ['log', 'warn', 'error']
  \ ]

autocmd FileType {gitrebase} let b:switch_custom_definitions =
  \ [
  \   ['pick', 'reword', 'edit', 'squash', 'fixup', 'exec', 'break', 'drop', 'label', 'reset', 'merge']
  \ ]

