let g:ctrlp_map = '<leader>p' " set the default opening command to use when pressing the above mapping
let g:ctrlp_max_height = 10 " set the maximum height of the match window
let g:ctrlp_show_hidden = 1 " set this to 1 if you want CtrlP to scan for dotfiles and dotdirs
let g:ctrlp_open_new_file = 'v' " use this option to specify how the newly created file is to be opened when pressing <c-y>
let g:ctrlp_open_multiple_files = 'v' " if non-zero, this will enable opening multiple files with <c-z> and <c-o>
let g:ctrlp_jump_to_buffer = 'Et' " when opening a file, if it's already open in a window somewhere, CtrlP will try to jump to it instead of opening a new instance
let g:ctrlp_extensions = ['quickfix'] " extensions are optional. to enable an extension, add its name to the variable g:ctrlp_extensions
if executable('ag')
  " Specify an external tool to use for listing files instead of using Vim's |globpath()|. Use %s in place of the target directory
  " ag ./ --files-with-matches --nocolor --hidden --path-to-agignore ./.agignore -g ""
  let g:ctrlp_user_command = ['ag %s --hidden --nocolor --path-to-agignore .agignore -g ""']
  let g:ctrlp_use_caching = 0 " set to 1 to enable caching
else
  let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files'] " Specify an external tool to use for listing files instead of using Vim's |globpath()|. Use %s in place of the target directory
  "let g:ctrlp_clear_cache_on_exit = 1 " set this to 0 to enable cross-session caching by not deleting the cache files upon exiting Vim
  "let g:ctrlp_cache_dir = '.ctrlp-cache' " set the directory to store the cache files
endif
