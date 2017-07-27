" source ~/.vimrc.local if it exists
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
if filereadable(expand('./.vimrc'))
  source ./.vimrc
endif
