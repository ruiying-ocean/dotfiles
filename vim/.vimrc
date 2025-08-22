" Basic Settings
set nocompatible              " Disable vi compatibility
set encoding=utf-8            " Use UTF-8 encoding
set backspace=indent,eol,start " Make backspace work normally

" Visual Settings
set number                    " Show line numbers
set relativenumber           " Show relative line numbers
set cursorline              " Highlight current line
set showmatch               " Highlight matching brackets
set hlsearch                " Highlight search results
set incsearch               " Incremental search
set ignorecase              " Case insensitive search
set smartcase               " Case sensitive if uppercase present

" Indentation
set autoindent              " Auto indent new lines
set smartindent             " Smart indenting
set expandtab               " Use spaces instead of tabs
set tabstop=4               " Tab width
set shiftwidth=4            " Indent width
set softtabstop=4           " Soft tab width

" UI Improvements
set ruler                   " Show cursor position
set showcmd                 " Show command in status line
set laststatus=2            " Always show status line
set wildmenu                " Enhanced command completion
set scrolloff=5             " Keep 5 lines visible when scrolling
set sidescrolloff=5         " Keep 5 columns visible when scrolling
set wrap                    " Wrap long lines
set linebreak               " Break lines at word boundaries

" Performance
set lazyredraw              " Don't redraw during macros
set ttyfast                 " Fast terminal connection

" File Handling
set autoread                " Auto reload changed files
set hidden                  " Allow hidden buffers
set noswapfile              " Disable swap files
set nobackup                " Disable backup files
set undofile                " Enable persistent undo
set undodir=~/.vim/undodir  " Undo directory

" Key Mappings
" Clear search highlighting with Ctrl+L
nnoremap <C-L> :nohlsearch<CR><C-L>

" Quick save with Ctrl+S (works in most terminals)
nnoremap <C-S> :w<CR>
inoremap <C-S> <Esc>:w<CR>a

" Move by visual lines (useful for wrapped text)
nnoremap j gj
nnoremap k gk

" Quick buffer switching
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

" Colors and Theme
syntax on                   " Enable syntax highlighting
set background=dark         " Dark background
colorscheme default         " Use default colorscheme

" Create undo directory if it doesn't exist
if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "p", 0700)
endif