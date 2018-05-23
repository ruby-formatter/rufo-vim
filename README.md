# rufo-vim

Ruby format for [vim](https://www.vim.org) via [rufo](https://github.com/ruby-formatter/rufo).

## Installation

First of all, install [rufo](https://github.com/ruby-formatter/rufo) via

        $ gem install rufo

Verify it works via

        $ rufo -v

For vim, if you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/ruby-formatter/rufo-vim.git

### Enable in .vimrc

Auto formatting is disabled by default, so you have to enable it in your `.vimrc`/`.gvimrc`

```vim
" Enable rufo (RUby FOrmat)
let g:rufo_auto_formatting = 1
```

Next time when you save the file code will be formatted

## Partial formatting

For formatting some part of the code select lines with Shift+V and call `:Rufo` command

## Options

`g:rufo_auto_formatting` - enable/disable auto formatting. Default value: 0 (disabled)

`g:rufo_errors_buffer_position` - errors buffer position. Possible values: 'top', 'bottom', 'left', 'right'.
Default: 'bottom'

`g:rufo_silence_errors` - Errors will not be shown if set to `1`. Possible values: 0 or 1. Default: 0

## Commands

`:Rufo` - run formatting. In Normal mode - format whole file, in Visual mode - format selected part

`:RufoOn` - enable auto formatting

`:RufoOff` - disable auto formatting

`:RufoToggle` - enable/disable auto formatting

## [Contributors](https://github.com/ruby-formatter/rufo-vim/graphs/contributors)

* Kiyoshi Murata (https://github.com/13k)
* Peter Leitzen (https://github.com/splattael)
* Alexander Skachko (https://github.com/lucerion)

Thank you :green_heart:

**Help is very welcome!**
