let mapleader=','

" Load legacy-vim-only settings
if has('nvim') == 0
  if filereadable(expand("~/.vim/.vim_legacy"))
    source ~/.vim/.vim_legacy
  endif
endif


function! PostInstallCoc(info) abort
  if a:info.status ==? 'installed' || a:info.force
    !yarn install
    call coc#add_extension(
          \ 'coc-css',
          \ 'coc-emoji',
          \ 'coc-emmet',
          \ 'coc-eslint',
          \ 'coc-git',
          \ 'coc-html',
          \ 'coc-json',
          \ 'coc-pairs',
          \ 'coc-prettier',
          \ 'coc-svelte',
          \ 'coc-svg',
          \ 'coc-tslint',
          \ 'coc-tsserver',
          \ 'coc-yaml',
          \ )

    " -- disabled coc.nvim extensions:
    " \ 'coc-omni',
    " \ 'coc-dictionary',
    " \ 'coc-java',
    " \ 'coc-vetur',
    " \ 'coc-wxml',
    " \ 'coc-stylelint',
    " \ 'coc-highlight',
    " \ 'coc-word',
    " \ 'coc-snippets',
  elseif a:info.status ==? 'updated'
    !npm install
    call coc#util#update()
  endif
endfunction

" Plug
call plug#begin('~/.vim/plugged')
Plug 'AndrewRadev/switch.vim'
" Plug 'APZelos/blamer.nvim'
Plug 'chriskempson/base16-vim'
" Plug 'danielwe/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
" Plug 'fatih/vim-go', { 'do': ':silent :GoUpdateBinaries' }
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'ianks/vim-tsx'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-github-dashboard'
Plug 'junegunn/vim-peekaboo'
" Plug 'junegunn/vim-xmark', { 'do': 'make' }
Plug 'leafgarland/typescript-vim'
" Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'maxmellon/vim-jsx-pretty'
" Plug 'michal-h21/vim-zettel'
Plug 'nelstrom/vim-visual-star-search'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'Quramy/tsuquyomi'
" Plug 'sheerun/vim-polyglot'
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'sjl/vitality.vim'
Plug 'suy/vim-context-commentstring'
" Plug 'takac/vim-hardtime'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'vim-scripts/calendar.vim--Matsumoto'
Plug 'vim-scripts/netrw.vim'
Plug 'vim-scripts/vis'
Plug 'vim-scripts/visualrepeat'
Plug 'vim-scripts/zoomwin'
Plug 'vimwiki/vimwiki'
" Plug 'w0rp/ale'
Plug 'wfleming/vim-codeclimate'
call plug#end()
" let g:python_host_prog = '/Users/adam/.asdf/installs/python/2.7.14/bin/python'

set clipboard=unnamed " "unnamed" to use the * register like unamed register. "autoselect" to always put selected text on the clipboard
set colorcolumn=+1,+2 " columns to highlight
set dictionary=/usr/share/dict/words " list of dictionary files for keyword completion
set expandtab " expand <Tab> to spaces in Insert mode
set exrc
set foldmethod=indent " folding type: "manual", "indent", "expr", "marker" or "syntax"
set foldnestmax=3 " maximum fold depth for when 'foldmethod is "indent" or "syntax"
set hidden " don't unload a buffer when no longer shown in a window
if has('nvim')
  set inccommand=split
endif
set lazyredraw
set linebreak " wrap long lines at a character in 'breakat'
set list " show <Tab> as ^I and end-of-line as $
set listchars=tab:\ \ ,trail:· " list strings used for list mode
set nobackup " don't keep a backup after overwriting a file
set nofoldenable " set to display all folds closed
set noswapfile " don't use a swap file for this buffer
set nowrap " long lines don't wrap
set nowritebackup " don't write a backup file before overwriting a file
set number " relativenumber " show the line number for each line
set scrolloff=10 " number of screen lines to show around the cursor
set secure
set shiftwidth=2 " number of spaces used for each step of (auto)indent
set shortmess=aoOstTWAI " list of flags to make messages shorter
set showmode " display the current mode in the status line
set sidescrolloff=15 " minimal number of columns to keep left and right of the cursor
set smartindent " do clever autoindenting
set softtabstop=2 " if non-zero, number of spaces to insert for a <Tab>
set spellfile=~/.vim/spellfile.utf-8.add " file that "zg" adds good words to
set splitbelow " a new window is put below the current one
set splitright " a new window is put right of the current one
set statusline+=%= " set right-side status info after this line
set statusline+=%l/%L:%v " set <line number>/<total lines>:<column>
set statusline+=\  " set ending space
set statusline+=\ %f\ %m\ %r " show filename/path
set statusline= " alternate format to be used for a status line
set tabstop=2 " number of spaces a <Tab> in the text stands for
if isdirectory($HOME . '/.vim_undo') == 0
  :silent !mkdir -p ~/.vim_undo > /dev/null 2>&1
endif
set undodir=~/.vim_undo " list of directories for undo files
set undofile " automatically save and restore undo history
set viminfo='100,f1 " list that specifies what to write in the viminfo file
set wildignore=*.o,*.obj,*~,.hg,.git,.svn,.vim-tags,*vim/backups*,*.swp,*.spl,*.DS_Store,*.jpg,*.bmp,*.gif,*.png,*.jpeg,*/tmp,*/log,*/vendor/bundle,*/vendor/cache,*/bin,*.zip " list of patterns to ignore files for file name completion
set wildmode=list:longest " specifies how command line completion works

set termguicolors
syntax enable " switch on syntax highlighting
if $TERM =~ '256'
  let base16colorspace=256
endif
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
else
  colorscheme base16-default-dark
endif
highlight Comment cterm=italic
highlight Search ctermfg=black ctermbg=lightgrey
highlight Visual ctermfg=bg ctermbg=fg

autocmd FocusGained * :checktime
filetype plugin on " enable loading the plugin files for specific file types
filetype indent on " enable loading the indent file for specific file types
augroup filetypes
  autocmd!
  autocmd FileType * setlocal formatprg=
  autocmd BufReadPost * silent! lcd .
  " Docker
  autocmd BufNewFile,BufRead Dockerfile* set filetype=Dockerfile
  " Indent-based folding
  autocmd BufRead,BufNewFile,BufWrite *.{coffee,json,py,yaml,yml} set foldmethod=indent
  " JavaScript
  autocmd BufRead,BufNewFile,BufWrite *.{js.asp,es6,jsx,mjs} set filetype=javascript
  autocmd BufRead,BufNewFile,BufWrite .{babelrc,eslintrc,prettierrc} set filetype=json
  autocmd BufRead,BufNewFile,BufWrite {*bashrc*,*.bash} set filetype=sh
  " JSON
  autocmd BufNewFile,BufRead *.json set filetype=json
  autocmd FileType json setlocal formatprg=jq\ -sM\ .
  " Ruby
  autocmd BufRead,BufNewFile,BufWrite Brewfile set syntax=ruby
  " Writing
  autocmd BufRead,BufNewFile,BufWrite *.md set syntax=markdown.vimwiki
  autocmd Filetype md set wrap linebreak nolist nonumber norelativenumber spell textwidth=80
  autocmd Filetype txt set wrap linebreak nolist spell textwidth=80
  " Property lists
  autocmd BufRead,BufNewFile,BufWrite *.{plist,xml} set filetype=xml
  " Ruby
  autocmd BufRead,BufNewFile,BufWrite {Capfile,Gemfile,Guardfile,Procfile,Rakefile,Thorfile,Vagrantfile,.ru,.caprc,.irbrc,.jbuilder,.rake} set filetype=ruby
augroup end

" Insert timestamp
nmap <leader>ts :.! date -R<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" write
nnoremap <leader>w :w<cr>
" nnoremap <leader>bl :set bg=light<cr>
" nnoremap <leader>bd :set bg=dark<cr>
nnoremap <leader>n :set invnumber<cr>
nnoremap <leader>m :set invrelativenumber<cr>
" `gf` opens file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<cr>
" automatically reload vimrc when it's saved
autocmd! BufWritePost {~/.vimrc,~/.vim/init.vim} source ~/.vim/init.vim
" equalize windows
nnoremap <leader>= :wincmd =<cr>
" toggle "keep current line centered" mode
nnoremap <leader>C :let &scrolloff=999-&scrolloff<cr>
" clean trailing whitespace
nnoremap <leader>W mz:%s/\s\+$//<cr>:let @/=''<cr>`z
" keep cursor in place when joining lines
nnoremap J mzJ`z
" yank from cursor to end of line
nnoremap Y y$
" Go to matching symbol with tab
nnoremap <tab> %
vnoremap <tab> %
" move across wrapped lines better
" noremap j gj
" noremap k gk
" noremap gj j
" noremap gk k
" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv
" Space bar toggles folds.
nnoremap <Space> za
vnoremap <Space> za
nnoremap <leader>rr :redraw!<cr>
nnoremap <leader>r :source ~/.vim/init.vim<cr>:echo 'Reloaded ~/.vim/init.vim'<cr>
" custom grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
command! -nargs=+ CustomGrep :execute "silent grep! --nogroup --nocolor <args>" | copen | redraw!
" nnoremap <leader>g :CustomGrep
" sudo write
command! W w !sudo tee % > /dev/null
" command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
" emacs style ctrl-a and ctrl-e in insert mode for begin/end of line
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

augroup vimrc
  autocmd!
augroup END
