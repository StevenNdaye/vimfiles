" General "{{{
set nocompatible " Be iMproved
set history=1000 " Remember more commands and search history
set undolevels=1000 " Use many levels of undo
set wildmode=list:longest " Make cmdline tab completion similar to bash
set scrolloff=3 " Maintain more context around the cursor
set backupdir=~/.vimbackup,/tmp " Group backup files in one place
set directory=~/.vimbackup,/tmp " Group swap files in one place
" "}}}

" Searching "{{{
set incsearch " Enable incremental search
set ignorecase " Ignore case sensitivity
set smartcase " Enable case-smart searching
set hlsearch " Highlight search matches
" "}}}

" Formatting "{{{
set expandtab " Insert space characters whenever the tab key is pressed
set tabstop=2 " Number of spaces for a tab
set shiftwidth=2 " Number of space characters inserted for indentation
set softtabstop=2 " Makes the backspace key treat the two spaces like a tab (so one backspace goes back a full 2 spaces)
set autoindent " Copy the indentation from the previous line, when starting a new line
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set nowrap " Disable line wrapping

au BufWritePre *.css,*.html,*.js,*.php,*.rb,*.sql :%s/\s\+$//e " Remove trailing spaces before saving
au BufRead,BufNewFile *.eruby set ft=eruby.html
au BufRead,BufNewFile *.php set ft=php.html
au BufRead,BufNewFile *.md,*.mkd set ft=markdown
" "}}}

" Folding "{{{
set foldmethod=indent " Fold based on indent
set foldnestmax=10 " Max folding levels
set nofoldenable " Do not fold by default
set foldlevel=1
" "}}}

" Visual "{{{
set number " Display line numbers
set cursorline " Highlight current line
set list " Display unprintable chars
set listchars=tab:�.,eol:�,trail:.,extends:#,precedes:#,nbsp:� " Unprintable chars
" "}}}

" Set $VIMHOME and load bundles "{{{
if has('unix')
  let $VIMHOME = $HOME."/.vim"
else
  let $VIMHOME = $VIM."/vimfiles"
endif

so $VIMHOME/vimbundles.vim " Load vundle
" "}}}

" Syntax highlighting "{{{
syntax on " Turn it on

set t_Co=256 " Enable 256 colors
set background=dark " Background style

if $TERM == 'xterm-256color'
  color railscasts
else
  color default
endif
" "}}}

" Key mappings "{{{

" F keys
noremap <silent><F2> :TagbarToggle<CR>
noremap <silent><F3> :set hlsearch!<CR>
noremap <silent><F4> :GundoToggle<CR>
set pastetoggle=<F6>
noremap <silent><F7> :set spell!<CR>
noremap <silent><F8> :set wrap! linebreak! list! spell! spelllang=en,pt<CR> " Text editing mode
noremap <silent><F10> <ESC> :tab ball<CR> " Opens one tab for each open buffer

" Tab and SHIFT-Tab for indenting while on insert mode
imap <Tab> <ESC>>>i
imap <S-Tab> <ESC><<i

" Tab and SHIFT-Tab for indenting multiple lines
vmap <Tab> >gv
vmap <S-Tab> <gv

" CTRL+Space for autocompleting
imap <C-Space> <C-x><C-o>

" CTRL+c and CTRL+v for copying and pasting
imap <C-v> <ESC>"+gpi
map <C-c> "+y

" ALT+k / ALT+j for moving lines around
vnoremap <A-k> :m-2<CR>gv=gv
vnoremap <A-j> :m'>+<CR>gv=gv

" Navigate through wrapped lines
vmap <Up> gk
vmap <Down> gj
vmap 0 g^
vmap $ g$
nmap <Up> gk
nmap <Down> gj
nmap 0 g^
nmap $ g$

" Open path/url under cursor (requires xolox's vim-shell)
nmap <A-o> viWy :Open <C-r>*<CR>

" Change path to current file dir
nmap <leader>cd :lcd %:p:h<CR>

" Run file with PHP CLI
au FileType php noremap <C-m> :w!<CR>:!/opt/lampp/bin/php %<CR>

" PHP parser check
au FileType php noremap <C-l> :!/opt/lampp/bin/php -l %<CR>
" "}}}

" Status line "{{{
if has("statusline")
  set laststatus=2

  " set statusline+=%<\                                 " truncation point
  " set statusline+=[%n]\                               " buffer number
  " set statusline+=%t\                                 " file name

  " set statusline+=[%{strlen(&ft)?&ft:'none'}\|        " filetype
  " set statusline+=%{strlen(&fenc)?&fenc:&enc}\|       " encoding
  " set statusline+=%{&fileformat}]\                    " file format

  " set statusline+=%#error#
  " set statusline+=%{&list?'['.nr2char(182).']':''}    " warns if list mode is enabled
  " set statusline+=%{&wrap?'[wrap]':''}                " warns wrap is enabled
  " set statusline+=%h%m%r%w                            " flags
  " set statusline+=%{StatuslineTrailingSpaceWarning()} " warns if there trailing spaces
  " set statusline+=%*

  " set statusline+=%=                                  " left/right separator
  " set statusline+=%(\ %{VisualSelectionSize()}%)\     " display selection count
  " set statusline+=%-14.(%l,%c%V%)                     " current line and column
  " set statusline+=\ %P                                " percent through file

  " hi StatusLine ctermfg=0 ctermbg=7 term=reverse
endif
" "}}}

so $VIMHOME/functions.vim " Load custom funcions
