set columns=80      " Number of columns
set lines=35        " Number of lines

set guioptions-=m   " Remove the menu
set guioptions-=T   " Remove the toolbar
set guioptions-=L   " Remove left hand scrollbar
set guioptions-=r   " Remove right hand scrollbar

set nomousehide     " Do not hide mouse pointer when using NERDTree

if has('mac')
  set guifont=Monaco\ for\ Powerline:h14
elseif has('unix')
  set guifont=Ubuntu\ Mono\ 14
else
  set guifont=Consolas:h12
endif

let g:molokai_original = 1
color molokai

hi Define guifg=#F92672
hi Special gui=none
hi Type gui=italic
hi rubyClass guifg=#F92672 gui=none
hi rubyControl guifg=#F92672 gui=none

" The following color groups depend on rails.vim
hi rubyRailsARMethod guifg=#A6E22E
hi rubyRailsMethod guifg=#A4E7F4
hi link rubyRailsControllerMethod rubyRailsARMethod
