" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'ycm-core/YouCompleteMe'

" Initialize plugin system
call plug#end()

" Enable filetype detection
filetype on

" Set the filetype based on the file's extension, but only if
" 'filetype' has not already been set
autocmd BufNewFile,BufRead *.def set syntax=cpp

" LLVM Makefiles can have names such as Makefile.rules or TEST.nightly.Makefile,
" so it's important to categorize them as such.
augroup filetype
  au! BufRead,BufNewFile *Makefile* set filetype=make
augroup END

" Enable syntax highlighting for LLVM files. To use, copy
" utils/vim/syntax/llvm.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.ll   set filetype=llvm
augroup END

" Enable syntax highlighting for tablegen files. To use, copy
" utils/vim/syntax/tablegen.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.td   set filetype=tablegen
augroup END

" In Makefiles, don't expand tabs to spaces, since we need the actual tabs
autocmd FileType make set noexpandtab

" Airline
set t_Co=256
let g:airline_powerline_fonts = 1
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" YCM
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_clangd_binary_path = '/home/eumakri/Documents/clang-9-rc3/stage1/bin/clangd'
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_args = ['-log=verbose', '-pretty', '--background-index']
"let g:ycm_global_ycm_extra_conf = '/home/szelethus/.vim/ycm_extra_conf.jsondb/ycm_extra_conf.jsondb.py'

" NerdTree
" Autostart :
" autocmd vimenter * NERDTree

" Key to toggle Nerd Tree
map <C-n> :NERDTreeToggle<CR>

" Performance for Raspberry or other low end systems.
" Also turn line numbering off!
" set nocursorcolumn
" set nocursorline
" set norelativenumber
" syntax sync minlines=256


" General
set nocompatible
set history=7000
set backspace=indent,eol,start

if has ('mouse')
  set mouse=a
endif

" Theme
set background=dark
colorscheme molokai

" Syntax highlighting
syntax on
filetype plugin indent on

" Numbering
set number
set relativenumber

set hidden

au BufReadPost *.def set syntax=ini

" Set to auto read when a file is changed from the outside
set autoread

" Completions
set wildmenu
set showcmd

" Show line and column
set ruler
" Show the column limit
set colorcolumn=80

" highlighting search
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

set autoindent

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having
" to "press <Enter> to continue"
" set cmdheight=2

" tabs to spaces
set expandtab

set shiftwidth=2
set tabstop=2

set smarttab

" Matching braces
set showmatch
" Matching angle brackets for metaprograms
set matchpairs+=<:>

" For airline
set laststatus=2

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.out

" No annoying sound on errors
set noerrorbells
set novisualbell

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif
" Remember info about open buffers on close
set viminfo^=%

" Change leader from '\' to ' '
map <Space> <Leader>

map <Leader>yi :YcmCompleter GoToInclude<CR>
map <Leader>yj :YcmCompleter GoToDefinition<CR>
map <Leader>yf :YcmCompleter GoToReferences<CR>
map <Leader>yc :YcmCompleter GetDoc<CR>

noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> gk k
noremap  <buffer> <silent> gj j

" Buffer switch
nnoremap <F3> :bnext <CR>
nnoremap <F2> :bprevious <CR>
nnoremap <F4> :buffers<CR>:buffer<Space>

command Bc bp|bd#
autocmd VimLeave * call system("xsel -ib", getreg('+'))
