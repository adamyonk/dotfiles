## Topical dotfiles

Everything is built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. To keep things simple with ZSH scripts, I keep
anything ZSH-related in the /zsh directory and all other config files go in
there respective topical directory.

## Installation ##

- `git clone git://github.com/adamyonk/dotfiles ~/.dotfiles`
- `cd ~/.dotfiles`
- `rake install`

The install rake task will symlink the appropriate files in `.dotfiles` to your
home directory. Everything is configured and tweaked within `~/.dotfiles`,
though. All files and folders ending in `.symlink` get, you guessed it,
symlinked. For example: `~/.dotfiles/vim/vimrc.symlink` gets symlinked to
`~/.vimrc`.

## Components ##

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `./script/bootstrap`.

## Credit ##

This project began as a fork of (and is heavily inspired by)
[holman's dotfiles](http://github.com/holman/dotfiles), and much of it's
ease is due to him. Lots of tag-teaming with
[pengwynn](http://github.com/pengwynn/dotfiles). Some of the vim setup was
borrowed from [skwp's dotfiles](http://github.com/skwp/dotfiles).
