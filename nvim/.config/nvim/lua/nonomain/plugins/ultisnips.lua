vim.g.UltiSnipsExpandTrigger       = '<c-s>'
vim.g.UltiSnipsJumpForwardTrigger  = '<c-j>'
vim.g.UltiSnipsJumpBackwardTrigger = '<c-k>'

-- Completion function for snippets: (can be replaced by the default completion of ultisnips {
-- vim.g.UltiSnipsListSnippets        = '<C-s>'
-- })

vim.cmd ([[
function! g:UltisnipsCompleteFunc(findstart, base)
	if a:findstart
		" locate the start of the word
		let line = getline('.')
		let start = col('.') - 1
		while start > 0 && (line[start - 1] =~ '\a' || line[start - 1] =~ '.' || line[start - 1] =~ '-')
			let start -= 1
		endwhile
		return start
	else
		let ins_words = []
		for [snippet, desc] in items(UltiSnips#SnippetsInCurrentScope())
			if g:devicons
				let desc = ' ' .. desc
			endif
			let ins_words = add(ins_words, { 'word' : snippet, 'menu' : desc } )
		endfor

		let matches = []
		for i in range(len(ins_words))
			if ins_words[i].word =~ '^' . a:base
				let matches = add(matches, ins_words[i])
			endif
		endfor

		let ins_res = { 'words' : matches }
		return ins_res
	endif
endfun

set completefunc=g:UltisnipsCompleteFunc
]])
