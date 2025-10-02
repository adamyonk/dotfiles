if [ -f $HOME/.profile ]; then
  . $HOME/.profile
fi

if [ -f $HOME/.bashrc ]; then
  . $HOME/.bashrc
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/adam/.lmstudio/bin"
# End of LM Studio CLI section

