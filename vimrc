" General
set showcmd
set nocompatible " Not old vi version
execute pathogen#infect()
syntax on " Syntax highlight

" Font
set guifont=Sauce\ Code\ Powerline:h18

" Solarize theme
set background=dark
colorscheme solarized

set nu " Show line numbers
filetype indent plugin on
nnoremap <silent> <F7> :set cursorline!<CR>
set nobackup
set noswapfile

" Update time
set updatetime=250

" NerdTree map key
map <C-n> :NERDTreeToggle<CR>

" Show file options above the command line
set wildmenu

" Wildignore
set wildignore+=**/node_modules   " ignores node_modules

" Copy pasted from who knows where
set linebreak " Break lines at word (requires Wrap lines)
set showbreak=+++ " Wrap-broken line prefix
set textwidth=100 " Line wrap (number of cols)
set showmatch " Highlight matching brace
set visualbell  " Use visual bell (no beeping)

set hlsearch  " Highlight all search results
set smartcase " Enable smart-case search
set ignorecase  " Always case-insensitive
set incsearch " Searches for strings incrementally

set autoindent  " Auto-indent new lines
set shiftwidth=4  " Number of auto-indent spaces
set smartindent " Enable smart-indent
set smarttab  " Enable smart-tabs
set softtabstop=4 " Number of spaces per Tab

" Advanced
set ruler " Show row and column ruler information

set undolevels=1000 " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour

" Javascript
let g:jsx_ext_required = 0

" Ctrlp fuzzy search
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.sass-cache$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" Plugins
call plug#begin()
Plug 'mxw/vim-jsx'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'scrooloose/nerdtree'
call plug#end()

