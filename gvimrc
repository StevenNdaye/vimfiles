set lines=33        " Number of lines
set columns=84      " Number of columns

set guioptions-=m   " Remove the menu
set guioptions-=T   " Remove the toolbar
set guioptions-=L   " Remove left hand scrollbar
set guioptions-=r   " Remove right hand scrollbar

set nomousehide     " Do not hide mouse pointer when using NERDTree

if has("gui_win32") || has("gui_win32s")
  set guifont=Consolas:h12
else
  set guifont=Ubuntu\ Mono\ 14
endif

let g:molokai_original = 1
color molokai
highlight Special gui=NONE

" color railscasts
" hi MatchParen gui=bold guibg=#333435 guifg=yellow

" color badwolf
