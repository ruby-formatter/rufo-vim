# rufo-vim

Ruby format in [vim](https://www.vim.org) via [rufo](https://github.com/asterite/rufo)

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

## Contribution / Help wanted!

I use vim for a while now but I am a newbie scripting it.

**Help is very welcome!**

## TODO

- [ ] Format before saving using `BufWritePre` (see [rust.vim](https://github.com/rust-lang/rust.vim/))
- [ ] Show actual error messages
