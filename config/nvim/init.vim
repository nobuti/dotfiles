" Neovim init — sources legacy vimrc for shared config.
" Plugins install to nvim data dir, not ~/.vim/plugged.
let g:plug_home = stdpath('data') . '/plugged'

source ~/.vimrc
