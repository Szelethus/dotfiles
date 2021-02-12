set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.

Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'lyuts/vim-rtags'
Plugin 'vim-latex/vim-latex'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

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
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" Enable syntax highlighting for tablegen files. To use, copy
" utils/vim/syntax/tablegen.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.td     set filetype=tablegen
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

"===------------------------------- YCM ------------------------------------==="
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_clangd_binary_path = '/home/szelethus/Documents/pgo_llvm_project/pgo_build/bin/clangd'
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_args=['-log=verbose', '-pretty', '--background-index']

noremap <Leader>yd :YcmForceCompileAndDiagnostics<CR> :YcmDiags<CR>
noremap <Leader>yr :YcmRestartServer<CR>
noremap <Leader>yt :YcmCompleter GetType<CR>
noremap <Leader>yc :YcmCompleter GetDoc<CR>
noremap <Leader>yf :YcmCompleter FixIt<CR>
noremap <Leader>yo :YcmCompleter Format<CR>
noremap <Leader>yw :YcmCompleter RefactorRename 
noremap <Leader>yh :YcmCompleter GoToReferences<CR>
noremap <Leader>yj :YcmCompleter GoToDefinition<CR>

" NerdTree
" Autostart :
" autocmd vimenter * NERDTree

" Key to toggle Nerd Tree
map <C-n> :NERDTreeToggle<CR>

" Clang Format
map <C-K> :pyf ~/Documents/clang6/bin/clang-format.py<cr>
imap <C-K> <c-o>:pyf ~/Documents/clang6/bin/clang-format.py<cr>

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

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <C-x> :Bc<CR>

nnoremap <leader>rm :map <leader>r<CR>


"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

" Change leader from '\' to '-'
map <Space> <Leader>

noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> gk k
noremap  <buffer> <silent> gj j

" Buffer switch
nnoremap <F3> :bnext <CR>
nnoremap <F2> :bprevious <CR>
nnoremap <F4> :buffers<CR>:buffer<Space>

command Bc bp|bd#
command C let @/=""
autocmd VimLeave * call system("xsel -ib", getreg('+'))

nmap <F1> <nop>

"vim-latex

let g:Tex_EnvironmentMaps = 0
let g:Tex_EnvironmentMenus = 0
let g:Tex_FontMaps = 0
let g:Tex_FontMenus = 0
let g:Tex_SectionMaps = 0
let g:Tex_SectionMenus = 0
