" General
set nocompatible " Be iMproved
set encoding=utf8 " Default encoding
set history=9999 " Remember more commands and search history
set undolevels=9999 " Use many levels of undo
set wildmode=list:longest,full " Command line tab completion option
set backupdir=~/.vimbackup,/tmp " Group backup files in one place
set directory=~/.vimbackup,/tmp " Group swap files in one place
set tags+=gems.tags " Load gem tags when present
set mouse=a " Enable mouse

" Appearance
set number " Display line numbers
set laststatus=2 " Enable statusline
set cursorline " Highlight current line
set listchars=tab:�.,eol:�,trail:.,extends:#,precedes:#,nbsp:� " Unprintable chars
set showcmd " Show keystrokes on statusline

" Searching
set incsearch " Enable incremental search
set ignorecase " Ignore case sensitivity
set smartcase " Enable case-smart searching
set hlsearch " Highlight search matches

" Folding
set foldmethod=indent " Fold based on indent
set foldnestmax=10 " Max folding levels
set nofoldenable " Do not fold by default
set foldlevel=1

" Formatting
set expandtab " Insert space characters whenever the tab key is pressed
set tabstop=2 " Number of spaces for a tab
set shiftwidth=2 " Number of space characters inserted for indentation
set softtabstop=2 " Makes the backspace key treat the two spaces like a tab (so one backspace goes back a full 2 spaces)
set autoindent " Copy the indentation from the previous line, when starting a new line
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set nowrap " Disable line wrapping

autocmd BufRead,BufNewFile *.erb set ft=eruby.html
autocmd BufRead,BufNewFile *.php set ft=php.html

" Key mappings
let mapleader = ","
nmap \ ,

map <F1> <nop>
nmap ; :
vmap ; :
imap jk <ESC>

if has('mac')
  map <D-c> "+y
  imap <D-v> jk"+gpi
else
  map <C-c> "+y
  imap <C-v> jk"+gpi
end

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

noremap <C-l> :bn<CR>
noremap <C-h> :bp<CR>

noremap + <C-w>+
noremap - <C-w>-
noremap ( <C-w><
noremap ) <C-w>>

nnoremap <leader>cd :lcd %:p:h<CR>

" Load additional config
if has('unix')
  let $VIMHOME = $HOME."/.vim"
else
  let $VIMHOME = $VIM."/vimfiles"
endif

so $VIMHOME/functions.vim " Custom funcions and commands
so $VIMHOME/bundles.vim " Vundle and bundles

" Syntax highlighting
syntax on " Turn it on

set t_Co=256 " Enable 256 colors
set background=dark " Background style

color neverland
