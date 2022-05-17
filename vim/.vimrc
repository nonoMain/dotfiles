" this is the empty vimrc file that copies the actual vimrc file
" I'v done it that way so people who copy just the .vimrc file don't run into
" problems cause all the good stuf is in the .vim directory

function! s:fileExists(path)
	if !empty(glob(a:path))
		return 1
	else
		return 0
	endif
endfunction

if s:fileExists("~/.vim/vimrc")
	source ~/.vim/vimrc
endif
