" Load plugins
filetype plugin indent on

" Search
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,full
set wildignore=*.swp,*.o,*.so,*.exe,*.dll

" Tab settings
set tabstop=2
set shiftwidth=2
set expandtab

" Hud
set termguicolors
syntax on
set ruler
set number
set nowrap
set fillchars=vert:\│
set colorcolumn=120
set textwidth=120
set hidden
set listchars=tab:»·,trail:·
set list
set scrolloff=3

" Tags
set tags=./tags;/,tags;/

" Backup Directories
set noswapfile
set backupdir=~/.config/nvim/backups,.
set directory=~/.config/nvim/swaps,.
if exists('&undodir')
  set undodir=~/.config/nvim/undo,.
endif

let mapleader=','
let maplocalleader=','

set updatetime=2500

" Jump key
nnoremap ` '
nnoremap ' `

" " Change pane
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Turn off search highlight
nnoremap <localleader>/ :nohlsearch<CR>

" Trim trailing whitespace
nnoremap <localleader>tw m`:%s/\s\+$//e<CR>:nohlsearch<CR>``

" Toggle paste mode
set pastetoggle=<leader>z

" Fancy macros
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Share OS clipboard
set clipboard=unnamed " "unnamed" to use the * register like unamed register. "autoselect" to always put selected text on the clipboard

" Copilot
" let g:copilot_no_tab_map = v:true
" let g:copilot_assume_mapped = v:true
" imap <silent><script><expr> <M-l> copilot#Accept("\<CR>")

" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
" set shortmess+=c
" imap <tab> <Plug>(completion_smart_tab)
" imap <s-tab> <Plug>(completion_smart_s_tab)

" set completeopt=menu,menuone,noselect
" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
