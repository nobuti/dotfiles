" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)

if (empty($TMUX))
    if (has("nvim"))
    " For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif

    " For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    " Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
   
    if (has("termguicolors"))
	set termguicolors
    endif
endif

" Plugins
call plug#begin()
Plug 'mxw/vim-jsx'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'rking/ag.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/unite.vim'
Plug 'bling/vim-airline'
call plug#end()

" General
set showcmd
set nocompatible " Not old vi version
execute pathogen#infect()
syntax on " Syntax highlight

" Font
set guifont=Sauce\ Code\ Powerline:h18

" Theme
set background=dark
colorscheme onedark
let g:onedark_termcolors=256

set nu " Show line numbers
filetype indent plugin on
nnoremap <silent> <F7> :set cursorline!<CR>
set nobackup
set noswapfile

" Update time
set updatetime=250

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
set softtabstop=2 " Number of spaces per Tab

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
let g:ctrlp_user_command = 'ag %s -l --nocolor --nogroup --hidden -g ""'

" Unite
let g:unite_source_history_yank_enable = 1
try
    let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
 catch
    endtry
" search a file in the filetree
nnoremap <space><space> :<C-u>Unite -start-insert file_rec/async<cr>
" " reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)

" Buffer tabs
:noremap <C-left> :bprev<CR>
:noremap <C-right> :bnext<CR>

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
"
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
