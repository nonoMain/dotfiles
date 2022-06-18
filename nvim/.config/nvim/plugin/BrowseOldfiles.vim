let s:last_bufNr = 0
let s:files_shown = []

if !exists('g:historyIgnore')
	let s:historyIgnore = [
	\ 'vim\/runtime\/doc\/.*.txt',
	\ 'nvim\/.*\/doc\/.*.txt',
	\ ]
endif

function! s:fileExists(path)
	if !empty(glob(a:path))
		return 1
	else
		return 0
	endif
endfunction

function! s:openFileUnderCursor() abort
	let l:file = s:files_shown[line('.') - 1]
	execute 'e' fnameescape(l:file)
endfunction

function! s:openBrowser()
	let s:files_shown = []
	enew

	for l:file in v:oldfiles
		if !s:fileExists(l:file) | continue | endif
		let l:ignore = 0
		let l:symbol = ""
		let l:line = ""
		if g:devicons
			if isdirectory(l:file)
				let l:symbol = luaeval("require(\'nonomain/utilities/ftdevicons\').getDirectorySymbol('closed')")
			else
				let l:symbol = luaeval("require(\'nonomain/utilities/ftdevicons\').getFilenameSymbol('" .. fnamemodify(l:file, ':t') .. "')")
				if l:symbol == v:null
					let l:symbol = luaeval("require(\'nonomain/utilities/ftdevicons\').getExtentionSymbol('" .. fnamemodify(l:file, ':e') .. "')")
				endif
			endif
			let l:symbol = "\[" .. l:symbol .. "\] "
		endif

		for l:pattern in s:historyIgnore
			if  match(l:file, l:pattern) != -1
				let l:ignore = 1
				break
			endif
		endfor

		if !l:ignore
			let l:line = l:symbol .. l:file
			let s:files_shown += [l:file]
			silent put = l:line
		endif
	endfor
	silent exe "g/^$/d_"

	nnoremap <silent> <buffer> <CR> :call <SID>openFileUnderCursor()<CR>

	setlocal nomodifiable noswapfile nospell nowrap
	setlocal buftype=nofile bufhidden=delete conceallevel=2 filetype=oldfilesBroswer
endfunction

function! BrowseOldfiles#ToggleHistory()
	let l:amountOfbuffers = len(filter(range(1, bufnr('$')), 'bufexists(v:val)'))
	if &filetype == "oldfilesBroswer" " quit while browsing
			silent execute "Bwipeout"
	else
		let s:last_bufNr = bufnr()
		call s:openBrowser()
	endif
endfunction

augroup oldfilesBrowser
  autocmd!
  autocmd FileType oldfilesBroswer setlocal bufhidden=wipe
augroup end

nnoremap <silent> <leader>h :call BrowseOldfiles#ToggleHistory()<CR>
