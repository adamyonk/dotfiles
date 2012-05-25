# goog

goog is a command line tool that lets you perform Google searches from the
command line. Along with your query, you can specify the number of pages of
results you want and the time range you are interested in. 

You can output the result in simple, colored plain text in the shell, or you
can browse in interactive mode (with ways to pipe webpage text to other Unix
programs) or in Vim mode (where you are supplied with Vim key bindings to
quickly open any URL in the results in a web browser). 

goog can also install itself as a Vim plugin, giving you the power to run and
browse Google searches inside Vim. If you have `elinks` installed, you can even
read the webpages returned by the Google search inside your Vim session.

Personally my favorite way to use goog is the interactive mode (use the -i or
--interactive flag).

## Screenshot

Pure command line mode:

![screenshot](https://github.com/danchoi/goog/raw/master/screenshot.png)

goog as a Vim plugin, showing search results at the bottom, and a webpage opened inside 
the Vim session with the goog keybinding `<leader>O`.

![screenshot](https://github.com/danchoi/goog/raw/master/screenshot-vim.png)


## Install

    gem install goog


## Usage

```
Usage: goog [options] [query]
    -h, --help                       Show this message
    -d, --date-range [DATE RANGE]    Show results for date range. See below for options.
    -n, --num-pages [NUM PAGES]      Show NUM PAGES pages of results
    -c, --color                      Force color output
    -x, --expand                     Expand all results into web page text
    -e, --elinks                     Open results in elinks
    -i, --interactive                Prompt for selection
    -v, --vim                        Open results in Vim and bind <leader>o to open URL on or after cursor
        --install-plugin             Install Goog as a Vim plugin
        --version                    Show version

DATE RANGE options for -d option:
    h   last hour
    d   last day (24 hours)
    w   last week
    m   last month
    y   last year

VIM KEY MAPPINGS
    <leader>o       open URL on or after cursor in default external web browser
    <leader>O       open URL on or after cursor in split Vim window using elinks, links, or lynx

VIM PLUGIN COMMANDS

    :Goog [query]

      where query is any of the flags and arguments you can pass to the command
      line version, except for -v.

goog will run the Google search and print matches with syntax coloring in a
split Vim buffer.

In the GoogSearchResults buffer:

    CTRL-j          jumps to the next URL
    CTRL-k          jumps to the previous URL
    <leader>o       open URL on or after cursor in default external web browser
    <leader>O       open URL on or after cursor in split Vim window using elinks, links, or lynx
```

## Motivation

I wrote `goog` for the same reason I wrote
[vmail](https://github.com/danchoi/vmail),
[poddb](http://danielchoi.com/software/poddb_client.html), and
[vitunes](https://github.com/danchoi/vitunes): I believe that the command line,
supplemented by a Unix-style plain text editor like Vim, is in general a much
more powerful, productive, empowering, and creative environment for using a
computer than the web browser or GUI-style app.  In short, I follow the [Unix
philosophy](http://www.faqs.org/docs/artu/ch01s06.html) when it comes to 
the software tools I use.

## MIT License 

Copyright (c) 2012 Daniel Choi, http://danielchoi.com/software/

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


