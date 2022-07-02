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
					if l:symbol == v:null
						let l:symbol = luaeval("require(\'nonomain/utilities/ftdevicons\').default_extentionSymbol")
					endif
				endif
			endif
			let l:symbol = l:symbol
		endif

		for l:pattern in s:historyIgnore
			if  match(l:file, l:pattern) != -1
				let l:ignore = 1
				break
			endif
		endfor

		if !l:ignore
			let l:line = l:symbol .. ' ' .. l:file
			let s:files_shown += [l:file]
			silent put = l:line
		endif
	endfor
	silent exe "g/^$/d_"

	nnoremap <silent> <buffer> <CR> :call <SID>openFileUnderCursor()<CR>

	setlocal colorcolumn=""
	setlocal nomodifiable noswapfile nospell nowrap
	setlocal buftype=nofile bufhidden=wipe conceallevel=2 filetype=oldfilesBroswer
endfunction

" Highlight icons inside this filetype
let s:devicons_color_icons_dict = {
\'Brown':[''],
\'Aqua':[''],
\'Blue':['', '', '', '', '', '', '', '', '', '', ''],
\'DarkBlue':['', '', '', '', ''],
\'Purple':['', '', '', '', '', '', ''],
\'Red':['', '', '', ''],
\'Yellow':['', ''],
\'Orange':['', '', '', '', '', '', '', '', '', 'λ', '', '', ''],
\'Pink':['', ''],
\'Salmon':['', ''],
\'Green':['', '', '', '', '', '', '', ''],
\'LightGreen':['﵂'],
\'Grey':['', '', '', ''],
\'White':['', '', '', '', '', '', ''],
\}

if g:devicons
	augroup devicons_colors
		autocmd!
		for color in keys(s:devicons_color_icons_dict)
			exec 'autocmd FileType oldfilesBroswer ' . 'syntax match ftdevicons'.color.' /\v'.join(s:devicons_color_icons_dict[color], '|').'/ containedin=ALL'
		endfor
	augroup END
endif

function! BrowseOldfiles#ToggleHistory()
	let l:amountOfbuffers = len(filter(range(1, bufnr('$')), 'bufexists(v:val)'))
	if &filetype == "oldfilesBroswer" " quit while browsing
			silent execute "Bwipeout"
	else
		let s:last_bufNr = bufnr()
		call s:openBrowser()
	endif
endfunction

nnoremap <silent> <leader>h :call BrowseOldfiles#ToggleHistory()<CR>

