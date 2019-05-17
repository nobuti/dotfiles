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
Plug 'bling/vim-airline'
Plug 'bronson/vim-trailing-whitespace'
Plug 'prettier/vim-prettier'
Plug 'wincent/command-t'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-vinegar'
Plug 'dyng/ctrlsf.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install({'tag':1})}}
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
set nohidden

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

" Closable netrw
augroup netrw_buf_hidden_fix
    autocmd!

    " Set all non-netrw buffers to bufhidden=hide
    autocmd BufWinEnter *
                \  if &ft != 'netrw'
                \|     set bufhidden=hide
                \| endif

augroup end

" Javascript
let g:jsx_ext_required = 0

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Emmet in jsx
let g:user_emmet_leader_key=','
let g:user_emmet_settings = {
\     'javascript': {
\	'extends': 'jsx',
\     },
\   }

" Ale
let g:ale_sign_error = '*' " Less aggressive than the default '>>'
let g:ale_sign_warning = '*'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\     'javascript': ['eslint'],
\   }

" Command-t remap
nmap <leader>p :CommandT<CR>
" Ignore node_modules with command-t
let g:CommandTWildIgnore=&wildignore . ",*/node_modules"

" Buffer tabs
:noremap <C-Left> :bprev<CR>
:noremap <C-Right> :bnext<CR>
:noremap <C-x> :bw<CR>
:noremap <C-n> :enew<CR>

" Windows navigation
nnoremap <leader>w <C-w><C-w>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"This unsets the "last search pattern" register by hitting return
noremap <CR> :noh<CR><CR>

" Open :CtrlSF with <Leader>f
nnoremap <leader>f :CtrlSF<Space>
vnoremap <leader>f :CtrlSF<Space>

"Move lines with Alt
nnoremap <A-Up> :m-2<CR>
nnoremap <A-Down> :m+<CR>
inoremap <A-Up> <Esc>:m-2<CR>
inoremap <A-Down> <Esc>:m+<CR>

" Moving lines in Visual mode
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

" Search under the cursor
:nnoremap <Leader>s /\<<C-r><C-w>\>
:nnoremap <Leader>r :%s/\<<C-r><C-w>\>/
