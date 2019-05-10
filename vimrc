" Plugins
call plug#begin()
Plug 'w0rp/ale'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'airblade/vim-gitgutter'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'sheerun/vim-polyglot'
Plug 'connorholyday/vim-snazzy'
Plug 'rking/ag.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'bling/vim-airline'
Plug 'bronson/vim-trailing-whitespace'
Plug 'prettier/vim-prettier'
Plug 'wincent/command-t'
Plug 'ap/vim-css-color'
call plug#end()


" General
set termguicolors
set showcmd
set nocompatible " Not old vi version
syntax on " Syntax highlight

" Leader
let mapleader = ","

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Theme
colorscheme snazzy
let g:SnazzyTransparent = 1

set nu " Show line numbers
filetype indent plugin on
nnoremap <silent> <F7> :set cursorline!<CR>
set nobackup
set noswapfile
set hidden

" Update time
set updatetime=250

" Show file options above the command line
set wildmenu

" Wildignore
set wildignore+=**/node_modules   " ignores node_modules

" Copy pasted from who knows where
set cursorline " Highlight current line
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
set shiftwidth=2  " Number of auto-indent spaces
set smartindent " Enable smart-indent
set smarttab  " Enable smart-tabs
set softtabstop=2 " Number of spaces per Tab

" Advanced
set ruler " Show row and column ruler information

set undolevels=1000 " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour

set wildignore+=*/node_modules/* " Don't search inside Node.js modules

" Javascript
let g:jsx_ext_required = 0

" Buffer tabs
:noremap <C-left> :bprev<CR>
:noremap <C-right> :bnext<CR>
:noremap <C-w> :bw<CR>

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"Move lines with Shift
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" Emmet in jsx
" let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_leader_key=','
let g:user_emmet_settings = {
\     'javascript': {
\	'extends': 'jsx',
\     },
\   }

" Ale
let g:ale_sign_error = '·' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\     'javascript': ['eslint'],
\   }

" Explore like vinegar
nnoremap - :Explore<CR>
let g:netrw_banner = 0

" Command-t remap
nmap <leader>p :CommandT<CR>

