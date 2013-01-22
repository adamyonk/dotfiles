## Topical dotfiles ##

Everything is built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. To keep things simple with ZSH scripts, I keep
anything ZSH-related in the /zsh directory and all other config files go in
there respective topical directory.

## Installation ##

- `git clone https://github.com/adamyonk/dotfiles.git ~/.dotfiles`
- `cd ~/.dotfiles`
- `./script/bootstrap`

The install rake task will symlink the appropriate files in `.dotfiles` to your
home directory. Everything is configured and tweaked within `~/.dotfiles`,
though. All files and folders ending in `.symlink` get, you guessed it,
symlinked. For example: `~/.dotfiles/vim/vimrc.symlink` gets symlinked to
`~/.vimrc`.

## Components ##

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.

## Credit ##

This project began as a fork of (and is heavily inspired by)
[holman's dotfiles](http://github.com/holman/dotfiles), and much of it's
ease is due to him. Lots of tag-teaming with
[pengwynn](http://github.com/pengwynn/dotfiles). Some of the vim setup was
borrowed from [skwp's dotfiles](http://github.com/skwp/dotfiles).
