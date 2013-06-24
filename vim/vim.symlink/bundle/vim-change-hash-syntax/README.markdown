# Change Hash Syntax

This plugin changes Ruby hash syntax to 1.9

    # before
    hash = { :one => 1, :two => 2 }

    # after
    hash = { one: 1, two: 2 }


# How to use

To change hash syntax, just call `:ChangeHashSyntax`.  By default it
operates on the entire file.  Pass a range (or use V to select some lines)
to restrict the portion of the file that gets fixed.

# Installation

    git clone git://github.com/ck3g/vim-change-hash-syntax.git
    cp vim-change-hash-syntax/plugin/change-hash-syntax.vim ~/.vim/plugin/

# License

Distributed under the same terms as Vim itself.
See `:help license`.
