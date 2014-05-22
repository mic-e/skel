syntax on
" set autoindent
set encoding=utf8
set background=dark
set noexpandtab
set tabstop=8
set softtabstop=8
set shiftwidth=8
set shiftround
set whichwrap+=<,>,h,l,[,]

highlight evilws ctermbg=red
" space indent /^\t*\zs \+/
" stray tab    /[^\t]\zs\t\+/
" trailing ws  /\s\+\%#\@<!$/
" tab          /\t/
2match evilws /^\t*\zs \+\|[^\t]\zs\t\+\|\s\+\%#\@<!$/
" trailing ws does not highlight when typing there; redraw when leaving insert mode
autocmd InsertLeave * redraw!

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END

" python-specific
au FileType python setlocal expandtab
au FileType python setlocal tabstop=8
au FileType python setlocal shiftwidth=4
au FileType python setlocal softtabstop=4
" highlight tabs and trailing whitespaces
au FileType python :2match evilws /\t\|\s\+\%#\@<!$/

" perl-specific
au FileType perl setlocal expandtab
au FileType perl setlocal tabstop=8
au FileType perl setlocal shiftwidth=4
au FileType perl setlocal softtabstop=4
" highlight tabs and trailing whitespaces
au FileType perl :2match evilws /\t\|\s\+\%#\@<!$/
