# rufo-vim

Ruby format for [vim](https://www.vim.org) via [rufo](https://github.com/asterite/rufo)

## Installation

First of all, install [rufo](https://github.com/asterite/rufo) via

        $ gem install rufo

Verify it works via

        $ rufo -v

For vim, if you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/splattael/rufo-vim.git

## Options

`g:rufo_auto_formatting` - enable/disable auto formatting. Default value: 0 (disabled)

## Commands

`:Rufo` - run formatting

`:RufoOn` - enable auto formatting

`:RufoOff` - disable auto formatting

`:RufoToggle` - enable/disable auto formatting

## Contribution / Help wanted!

I use vim for a while now but I am a newbie scripting it.

**Help is very welcome!**

## TODO

- [ ] Format before saving using `BufWritePre` (see [rust.vim](https://github.com/rust-lang/rust.vim/))
- [ ] Show actual error messages
