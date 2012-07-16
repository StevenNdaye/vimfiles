" Dynamically sets wildignore list {{{
autocmd VimEnter * call SetWildIgnore('.wildignore')
function! SetWildIgnore(ignored_strings_file)
  if filereadable(a:ignored_strings_file)
    let igstring = ''
    for oline in readfile(a:ignored_strings_file)
      let line = substitute(oline, '\s|\n|\r', '', "g")
      if line =~ '^#' | con | endif
      if line == '' | con  | endif
      if line =~ '^!' | con  | endif
      if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
      let igstring .= "," . line
    endfor
    let execstring = "set wildignore=".substitute(igstring, '^,', '', "g")
    execute execstring
  endif
endfunc
" }}}

" HandleScrollbars(): Displays right hand scrollbar only when needed {{{
function! HandleScrollbars()
  if line('$') > &lines
    set guioptions+=r
  else
    set guioptions-=r
  endif
endfunc
" }}}

" <SID>SynStack(): Shows syntax highlighting groups for word under cursor {{{
nmap <leader>sg :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}

" StatuslineTrailingSpaceWarning(): Returns '\s' if trailing white space is
" detected {{{
autocmd CursorHold,BufWritePost,InsertLeave * unlet! b:statusline_trailing_space_warning
function! StatuslineTrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '\s'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunc
" }}}

" VisualSelectionSize(): Returns number of (chars|lines|blocks) selected {{{
function! VisualSelectionSize()
  if mode() == "v"
    " Exit and re-enter visual mode, because the marks
    " ('< and '>) have not been updated yet.
    exe "normal \<ESC>gv"
    if line("'<") != line("'>")
      return (line("'>") - line("'<") + 1) . ' lines'
    else
      return (col("'>") - col("'<") + 1) . ' chars'
    endif
  elseif mode() == "V"
    exe "normal \<ESC>gv"
    return (line("'>") - line("'<") + 1) . ' lines'
  elseif mode() == "\<C-V>"
    exe "normal \<ESC>gv"
    return (line("'>") - line("'<") + 1) . 'x' . (abs(col("'>") - col("'<")) + 1) . ' block'
  else
    return ''
  endif
endfunc
" }}}

" WordProcessingToggle(): Toggles a few options for better long text editing {{{
function! WordProcessingToggle()
  if !exists('b:wordprocessing') || b:wordprocessing == 'false'
    let b:wordprocessing = 'true'
    setlocal tw=0 fo= lbr nolist sbr= spell spl=en,pt
    echo "Word processing mode enabled."
  else
    let b:wordprocessing = 'false'
    setlocal tw=80 fo=tcq nolbr list sbr=... nospell
    echo "Word processing mode disabled."
  endif
endfunc
" }}}

" HighlightOverLength(): Toggles overlength highlighting {{{
function! HighlightOverLength()
  highlight OverLength ctermbg=52 guibg=#592929

  if !exists('b:overlength') || b:overlength == 'false'
    let b:overlength = 'true'
    match OverLength /\%>80v.\+/
    echo "Overlength highlighting enabled."
  else
    let b:overlength = 'false'
    match OverLength //
    echo "Overlength highlighting disabled."
  endif
endfunc
" }}}

" ToggleFullscreen(): Toggles fullscreen mode {{{
function! ToggleFullscreen()
  if executable('wmctrl')
    exec 'silent !wmctrl -r :ACTIVE: -b toggle,fullscreen'
  else
    echo 'You must install wmctrl in order to use GVim fullscreen toggling.'
  endif
endfunc
" }}}

" HandleUnprintableChars(): Do not show invisible chars when editing files with
" no ft {{{
" au BufRead,BufWritePost,VimEnter * call HandleUnprintableChars()
function! HandleUnprintableChars()
  if strlen(&ft) == 0
    set nolist
  else
    set list
  endif
endfunc
" }}}

" CountListedBuffers(): Return number of open buffers {{{
function! CountListedBuffers()
  let cnt = 0
  for num in range(1, bufnr("$"))
    if buflisted(num)
      let cnt += 1
    endif
  endfor
  return cnt
endfunc
" }}}

" ConfirmQuit(): Confirm quit when more than 1 buffer is open {{{
" cnoremap <silent> q<cr>  call ConfirmQuit()<cr>
" cnoremap <silent> wq<cr> call ConfirmQuit()<cr>
" cnoremap <silent> x<cr> call ConfirmQuit()<cr>
function! ConfirmQuit()
  let confirmed = 1
  let open_buffers = CountListedBuffers()

  if open_buffers > 1
    let confirmed = confirm("There are " . open_buffers . " buffers open.\nDo you really want to quit?", "&Yes\n&No")
  endif

  if confirmed == 1
    quit
  endif
endfunc
" }}}

" CloseHiddenBuffers(): Close all hidden buffers {{{
command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete ".num
    endif
  endfor
endfunc
" }}}

" Sorts CSS file (Taken from http://bit.ly/znHbfG) {{{
autocmd FileType css command! SortCSSBraceContents :g#\({\n\)\@<=#.,/}/sort
" }}}

" Remove trailing spaces {{{
autocmd BufWritePre *.css,*.html,*.js,*.php,*.rb,*.sql RemoveTrailingSpaces
command! RemoveTrailingSpaces :%s/\s\+$//e | set nohlsearch
" }}}
