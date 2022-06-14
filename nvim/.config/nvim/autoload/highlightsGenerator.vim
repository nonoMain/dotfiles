let s:filename = $MYVIMRCFOLDER .. "/genereated_highlights.vim"

let s:common_colors = {
	\ '#000000':  16, '#00005f':  17, '#000087':  18, '#0000af':  19, '#0000d7':  20,
	\ '#0000ff':  21, '#005f00':  22, '#005f5f':  23, '#005f87':  24, '#005faf':  25,
	\ '#005fd7':  26, '#005fff':  27, '#008700':  28, '#00875f':  29, '#008787':  30,
	\ '#0087af':  31, '#0087d7':  32, '#0087ff':  33, '#00af00':  34, '#00af5f':  35,
	\ '#00af87':  36, '#00afaf':  37, '#00afd7':  38, '#00afff':  39, '#00d700':  40,
	\ '#00d75f':  41, '#00d787':  42, '#00d7af':  43, '#00d7d7':  44, '#00d7ff':  45,
	\ '#00ff00':  46, '#00ff5f':  47, '#00ff87':  48, '#00ffaf':  49, '#00ffd7':  50,
	\ '#00ffff':  51, '#5f0000':  52, '#5f005f':  53, '#5f0087':  54, '#5f00af':  55,
	\ '#5f00d7':  56, '#5f00ff':  57, '#5f5f00':  58, '#5f5f5f':  59, '#5f5f87':  60,
	\ '#5f5faf':  61, '#5f5fd7':  62, '#5f5fff':  63, '#5f8700':  64, '#5f875f':  65,
	\ '#5f8787':  66, '#5f87af':  67, '#5f87d7':  68, '#5f87ff':  69, '#5faf00':  70,
	\ '#5faf5f':  71, '#5faf87':  72, '#5fafaf':  73, '#5fafd7':  74, '#5fafff':  75,
	\ '#5fd700':  76, '#5fd75f':  77, '#5fd787':  78, '#5fd7af':  79, '#5fd7d7':  80,
	\ '#5fd7ff':  81, '#5fff00':  82, '#5fff5f':  83, '#5fff87':  84, '#5fffaf':  85,
	\ '#5fffd7':  86, '#5fffff':  87, '#870000':  88, '#87005f':  89, '#870087':  90,
	\ '#8700af':  91, '#8700d7':  92, '#8700ff':  93, '#875f00':  94, '#875f5f':  95,
	\ '#875f87':  96, '#875faf':  97, '#875fd7':  98, '#875fff':  99, '#878700': 100,
	\ '#87875f': 101, '#878787': 102, '#8787af': 103, '#8787d7': 104, '#8787ff': 105,
	\ '#87af00': 106, '#87af5f': 107, '#87af87': 108, '#87afaf': 109, '#87afd7': 110,
	\ '#87afff': 111, '#87d700': 112, '#87d75f': 113, '#87d787': 114, '#87d7af': 115,
	\ '#87d7d7': 116, '#87d7ff': 117, '#87ff00': 118, '#87ff5f': 119, '#87ff87': 120,
	\ '#87ffaf': 121, '#87ffd7': 122, '#87ffff': 123, '#af0000': 124, '#af005f': 125,
	\ '#af0087': 126, '#af00af': 127, '#af00d7': 128, '#af00ff': 129, '#af5f00': 130,
	\ '#af5f5f': 131, '#af5f87': 132, '#af5faf': 133, '#af5fd7': 134, '#af5fff': 135,
	\ '#af8700': 136, '#af875f': 137, '#af8787': 138, '#af87af': 139, '#af87d7': 140,
	\ '#af87ff': 141, '#afaf00': 142, '#afaf5f': 143, '#afaf87': 144, '#afafaf': 145,
	\ '#afafd7': 146, '#afafff': 147, '#afd700': 148, '#afd75f': 149, '#afd787': 150,
	\ '#afd7af': 151, '#afd7d7': 152, '#afd7ff': 153, '#afff00': 154, '#afff5f': 155,
	\ '#afff87': 156, '#afffaf': 157, '#afffd7': 158, '#afffff': 159, '#d70000': 160,
	\ '#d7005f': 161, '#d70087': 162, '#d700af': 163, '#d700d7': 164, '#d700ff': 165,
	\ '#d75f00': 166, '#d75f5f': 167, '#d75f87': 168, '#d75faf': 169, '#d75fd7': 170,
	\ '#d75fff': 171, '#d78700': 172, '#d7875f': 173, '#d78787': 174, '#d787af': 175,
	\ '#d787d7': 176, '#d787ff': 177, '#d7af00': 178, '#d7af5f': 179, '#d7af87': 180,
	\ '#d7afaf': 181, '#d7afd7': 182, '#d7afff': 183, '#d7d700': 184, '#d7d75f': 185,
	\ '#d7d787': 186, '#d7d7af': 187, '#d7d7d7': 188, '#d7d7ff': 189, '#d7ff00': 190,
	\ '#d7ff5f': 191, '#d7ff87': 192, '#d7ffaf': 193, '#d7ffd7': 194, '#d7ffff': 195,
	\ '#ff0000': 196, '#ff005f': 197, '#ff0087': 198, '#ff00af': 199, '#ff00d7': 200,
	\ '#ff00ff': 201, '#ff5f00': 202, '#ff5f5f': 203, '#ff5f87': 204, '#ff5faf': 205,
	\ '#ff5fd7': 206, '#ff5fff': 207, '#ff8700': 208, '#ff875f': 209, '#ff8787': 210,
	\ '#ff87af': 211, '#ff87d7': 212, '#ff87ff': 213, '#ffaf00': 214, '#ffaf5f': 215,
	\ '#ffaf87': 216, '#ffafaf': 217, '#ffafd7': 218, '#ffafff': 219, '#ffd700': 220,
	\ '#ffd75f': 221, '#ffd787': 222, '#ffd7af': 223, '#ffd7d7': 224, '#ffd7ff': 225,
	\ '#ffff00': 226, '#ffff5f': 227, '#ffff87': 228, '#ffffaf': 229, '#ffffd7': 230,
	\ '#ffffff': 231, '#080808': 232, '#121212': 233, '#1c1c1c': 234, '#262626': 235,
	\ '#303030': 236, '#3a3a3a': 237, '#444444': 238, '#4e4e4e': 239, '#585858': 240,
	\ '#626262': 241, '#6c6c6c': 242, '#767676': 243, '#808080': 244, '#8a8a8a': 245,
	\ '#949494': 246, '#9e9e9e': 247, '#a8a8a8': 248, '#b2b2b2': 249, '#bcbcbc': 250,
	\ '#c6c6c6': 251, '#d0d0d0': 252, '#dadada': 253, '#e4e4e4': 254, '#eeeeee': 255,
\}

" function, color is \"<html color value>\"
function! s:color_dist(color1, color2)
	let l:r1 = ("0x" . strpart(a:color1, 1, 3)) + 0
	let l:g1 = ("0x" . strpart(a:color1, 3, 3)) + 0
	let l:b1 = ("0x" . strpart(a:color1, 5, 3)) + 0

	let l:r2 = ("0x" . strpart(a:color2, 1, 3)) + 0
	let l:g2 = ("0x" . strpart(a:color2, 3, 3)) + 0
	let l:b2 = ("0x" . strpart(a:color2, 5, 3)) + 0

	let l:dr = l:r1 - l:r2
	let l:dg = l:g1 - l:g2
	let l:db = l:b1 - l:b2

	return (l:dr*l:dr) + (l:dg*l:dg) + (l:db*l:db)
endfunction

" function, color is \"#<html color value>\"
function! highlightsGenerator#GetClosetTermColor(color)
	let l:best_color = 0
	let l:best_distance = 0

	for l:key in keys(s:common_colors)
		let l:curr_distance = s:color_dist(a:color, l:key)
		if (l:best_color == 0) || (l:curr_distance < l:best_distance)
			let l:best_color = s:common_colors[l:key]
			let l:best_distance = l:curr_distance
		endif
	endfor

	return l:best_color
endfunction

" Coloring function
" Highlight Groups - H.G
" Keys:
" S: Special things like 'bold' 'italic'
" FG: frontground color
" BG: background color
function! highlightsGenerator#HighlightDict(key, dict)
	if has_key(a:dict, 'FG')
		let l:guifg = a:dict['FG']
		let l:ctermfg = highlightsGenerator#GetClosetTermColor(a:dict['FG'])
	else
		let l:guifg='NONE'
		let l:ctermfg='NONE'
	endif
	if has_key(a:dict, 'BG')
		if (a:dict['BG'] == 'NONE')
			let l:guibg = 'NONE'
			let l:ctermbg = 'NONE'
		else
			let l:guibg = a:dict['BG']
			let l:ctermbg = highlightsGenerator#GetClosetTermColor(a:dict['BG'])
		endif
	else
		let l:guibg='NONE'
		let l:ctermbg='NONE'
	endif
	if has_key(a:dict, 'S')
		let l:special = a:dict['S']
	else
		let l:special='NONE'
	endif
	execute "highlight " . a:key . " term=" . l:special . " gui=" . l:special . " ctermfg=" . l:ctermfg . " guifg=" . l:guifg . " ctermbg=" . l:ctermbg . " guibg=" . l:guibg
endfunction

" Coloring function
" Highlight Groups - H.G
" Keys:
" S: Special things like 'bold' 'italic'
" FG: frontground color
" BG: background color
function! s:AppendColorToFile(key, dict)
	if has_key(a:dict, 'FG')
		let l:guifg = a:dict['FG']
		let l:ctermfg = myUtils#BigBrother#GetClosetTermColor(a:dict['FG'])
	else
		let l:guifg='NONE'
		let l:ctermfg='NONE'
	endif
	if has_key(a:dict, 'BG')
		if (a:dict['BG'] == 'NONE')
			let l:guibg = 'NONE'
			let l:ctermbg = 'NONE'
		else
			let l:guibg = a:dict['BG']
			let l:ctermbg = myUtils#BigBrother#GetClosetTermColor(a:dict['BG'])
		endif
	else
		let l:guibg='NONE'
		let l:ctermbg='NONE'
	endif
	if has_key(a:dict, 'S')
		let l:special = a:dict['S']
	else
		let l:special='NONE'
	endif
	let l:name = a:key
	for i in range(20 - len(l:name))
		let l:name ..= ' '
	endfor
	let line = "highlight " . l:name . " guifg=". l:guifg . " guibg=" . l:guibg . " ctermfg=" . l:ctermfg . " ctermbg=" . l:ctermbg . " term=" . l:special . " gui=" . l:special
	call writefile([line], s:filename, "a")
endfunction

let s:ECP = {
\'bg'                : 'NONE',
\'string'            : '#d7875f',
\'comment'           : '#5f875f',
\'error'             : '#d70000',
\'number'            : '#afd7af',
\'bool'              : '#af87d7',
\'type'              : '#5fafaf',
\'keyword'           : '#87afff',
\'repeat'            : '#bf87d7',
\'function'          : '#d7d7af',
\'constant'          : '#d7d7af',
\'include'           : '#d75f87',
\'object'            : '#e4e4e4',
\'operator'          : '#af5f87',
\'bracket'           : '#d7875f',
\'special'           : '#5fafff',
\'selected'          : '#005f87',
\'fg'                : '#e4e4e4',
\'objFg'             : '#b2b2b2',
\'objBg'             : '#202020',
\'non_text'          : '#585858',
\'limitLines'        : '#444444',
\'cursorLines'       : '#19191d',
\'searchHighlight'   : '#005f87',
\'searchSelected'    : '#5f5f00',
\'visualSelection'   : '#005f87',
\'diffAdd'           : '#b2d2b2',
\'diffChange'        : '#e2e2b2',
\'diffDelete'        : '#e2b2b2',
\'infoFg'            : '#585858',
\'infoBg'            : '#2a2a2a',
\'symbolBranch'      : '#87afd7',
\'symbolWarFg'       : '#b7af5f',
\'symbolErrFg'       : '#a70000',
\'symbolDiagnostics' : '#a03d65',
\'symbolBufData'     : '#3da065',
\}

let s:CplexHighlights = {
	\'Normal'       : { "FG":s:ECP.fg,                "BG":s:ECP.bg },
	\'NormalFloat'  : { "FG":s:ECP.fg,                "BG":s:ECP.bg },
	\'Include'      : { "FG":s:ECP.include, },
	\'Comment'      : { "FG":s:ECP.comment, },
	\'Constant'     : { "FG":s:ECP.constant, },
	\'Delimiter'    : { "FG":s:ECP.fg,                "BG":s:ECP.bg },
	\'String'       : { "FG":s:ECP.string, },
	\'Character'    : { "FG":s:ECP.string, },
	\'Boolean'      : { "FG":s:ECP.bool, },
	\'Number'       : { "FG":s:ECP.number, },
	\'Float'        : { "FG":s:ECP.number, },
	\'Repeat'       : { "FG":s:ECP.repeat, },
	\'Keyword'      : { "FG":s:ECP.keyword, },
	\'Operator'     : { "FG":s:ECP.operator, },
	\'Function'     : { "FG":s:ECP.function, },
	\'Identifier'   : { "FG":s:ECP.object, },
	\'Type'         : { "FG":s:ECP.type, },
	\'Directory'    : { "FG":s:ECP.special, },
	\'Error'        : { "FG":s:ECP.error,             "S":'bold', },
	\'Special'      : { "FG":s:ECP.special, },
	\'Folded'       : { "FG":s:ECP.special,           "BG":s:ECP.non_text, },
	\'StatusLine'   : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'StatusLineNC' : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'Pmenu'        : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'PmenuSel'     : { "FG":s:ECP.objFg,             "BG":s:ECP.selected, },
	\'PmenuSbar'    : { "BG":s:ECP.limitLines, },
	\'PmenuThumb'   : { "BG":s:ECP.selected, },
	\'TabLineSel'   : { "FG":s:ECP.fg,                "BG":s:ECP.selected, },
	\'TabLine'      : { "FG":s:ECP.fg,                "BG":s:ECP.objBg, },
	\'TabLineFill'  : { "BG":s:ECP.objBg, },
	\'WildMenu'     : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'LineNr'       : { "FG":s:ECP.objFg, },
	\'ModeMsg'       : { "FG":s:ECP.objFg, },
	\'SignColumn'   : { "BG":s:ECP.bg, },
	\'CursorLineNr' : { "FG":s:ECP.fg, },
	\'CursorLine'   : { "BG":s:ECP.cursorLines, },
	\'ColorColumn'  : { "BG":s:ECP.cursorLines, },
	\'Cursor'       : { "S":'reverse', },
	\'VertSplit'    : { "FG":s:ECP.limitLines, },
	\'WinSeparator' : { "FG":s:ECP.limitLines, },
	\'IncSearch'    : { "BG":s:ECP.searchSelected, },
	\'Search'       : { "BG":s:ECP.searchHighlight, },
	\'Visual'       : { "BG":s:ECP.visualSelection, },
	\'VisualNOS'    : { "FG":s:ECP.objFg, },
	\'NonText'      : { "FG":s:ECP.non_text, },
	\'SpecialKey'   : { "FG":s:ECP.objFg, },
	\'DiffAdd'      : { "FG":s:ECP.diffAdd, },
	\'DiffChange'   : { "FG":s:ECP.diffChange, },
	\'DiffDelete'   : { "FG":s:ECP.diffDelete, },
\}

let s:StatusLineHighlights = {
	\'StlReg'               : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'StlRegBg'             : { "FG":s:ECP.objBg,                "BG":s:ECP.objBg, },
	\'StlBright'            : { "FG":s:ECP.objFg,             "BG":s:ECP.selected, },
	\'StlBranch'            : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'StlUBInfo'            : { "FG":s:ECP.objFg,             "BG":s:ECP.objBg, },
	\'StlBranchSymbol'      : { "FG":s:ECP.symbolBranch,      "BG":s:ECP.objBg,         "S":'BOLD', },
	\'StlDiagnosticSymbol'  : { "FG":s:ECP.symbolDiagnostics, "BG":s:ECP.objBg,         "S":'BOLD', },
	\'StlBufDataSymbol'     : { "FG":s:ECP.symbolBufData,     "BG":s:ECP.objBg,         "S":'BOLD', },
\}

" next few are based on other keys..
let s:StatusLineHighlights.StlSepBranch2Reg     = { "FG":s:StatusLineHighlights.StlBranch["BG"],       "BG":s:StatusLineHighlights['StlReg']["BG"], }
let s:StatusLineHighlights.StlSepBright2Branch  = { "FG":s:StatusLineHighlights.StlBright["BG"],       "BG":s:StatusLineHighlights['StlBranch']["BG"], }
let s:StatusLineHighlights.StlSepBright2Reg     = { "FG":s:StatusLineHighlights.StlBright["BG"],       "BG":s:StatusLineHighlights['StlReg']["BG"], }

let s:TablineHighlights = {
	\'TabLineSel'        : { "FG":s:ECP.objFg,       "BG":s:ECP.selected, },
	\'TabLine'           : { "FG":s:ECP.objFg,       "BG":s:ECP.objBg, },
	\'TabDiagnosticsReg' : { "FG":s:ECP.objFg,       "BG":s:ECP.objBg, },
	\'TabDiagnosticsWar' : { "FG":s:ECP.symbolWarFg, "BG":s:ECP.objBg, },
	\'TabDiagnosticsErr' : { "FG":s:ECP.symbolErrFg, "BG":s:ECP.objBg, },
	\'TabLineFill'       : { "BG":s:ECP.objBg, },
\}

function! highlightsGenerator#generate_highlights()
	call writefile(['" This file was genereated with ' .. expand('%') .. ' file'], s:filename, "a")

	call writefile(['"-------------- Cplex highlights --------------'], s:filename, "a")
	for key in keys(s:CplexHighlights)
		call s:AppendColorToFile(key, s:CplexHighlights[key])
	endfor

	call writefile(['"-------------- Statusline highlights --------------'], s:filename, "a")
	for key in keys(s:StatusLineHighlights)
		call s:AppendColorToFile(key, s:StatusLineHighlights[key])
	endfor

	call writefile(['"-------------- Tabline highlights --------------'], s:filename, "a")
	for key in keys(s:TablineHighlights)
		call s:AppendColorToFile(key, s:TablineHighlights[key])
	endfor
endfunction
