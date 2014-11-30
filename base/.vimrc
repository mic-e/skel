syntax on
" set autoindent
set encoding=utf8
set background=dark
set shiftround
set whichwrap+=<,>,h,l,[,]
set ignorecase smartcase

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" type w!! to sudo-write
cmap w!! exec 'w !sudo dd of=' . shellescape(expand('%'))
" type d? to show changes that would be written on write
cmap d?  exec 'w !git diff --no-index -- ' . shellescape(expand('%')) . ' -'

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

" whitespace code

highlight evilws ctermbg=red
" make sure that evilws is re-drawn when leaving insert mode
autocmd InsertLeave * redraw!

function! WSS(x)
	setlocal expandtab

	let &l:tabstop     = 8
	let &l:shiftwidth  = a:x
	let &l:softtabstop = a:x

	" highlight forbidden whitespaces:
	" tab          /\t/
	" trailing ws  /\s\+\%#\@<!$/
	:2match evilws /\t\|\s\+\%#\@<!$/
endfunction

function! WST(x)
	setlocal noexpandtab

	let &l:tabstop     = a:x
	let &l:shiftwidth  = a:x
	let &l:softtabstop = a:x

	" highlight forbidden whitespaces:
	" space indent /^\t*\zs \+/
	" stray tab    /[^\t]\zs\t\+/
	" trailing ws  /\s\+\%#\@<!$/
	:2match evilws /^\t*\zs \+\|[^\t]\zs\t\+\|\s\+\%#\@<!$/
endfunction

" default: 8-width tabs
call WST(8)
" filetypes where whitespaces are preferred
autocmd FileType python,perl,pyrex call WSS(4)

" short commands for manual usage
cmap ws2 call WSS(2)
cmap ws4 call WSS(4)
cmap wst call WST(8)
