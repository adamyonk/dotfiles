infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > /tmp/$TERM.terminfo
tic /tmp/$TERM.terminfo
