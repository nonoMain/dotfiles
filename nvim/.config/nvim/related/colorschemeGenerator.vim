let s:colorscheme = 'cplex'
let s:filename = fnamemodify($MYVIMRC, ':p:h') .. '/colors/' . s:colorscheme . '.vim'
let s:this_script_path = 'related/colorschemeGenerator.vim'

function! s:WriteColorschemeHeader()
	let l:header = []
	call add(l:header, '" header')
	call add(l:header, 'set background=dark')
	call add(l:header, 'highlight clear')
	call add(l:header, 'if exists("syntax_on")')
	call add(l:header, '  syntax reset')
	call add(l:header, 'endif')
	call add(l:header, 'let g:colors_name = "' . s:colorscheme . '"')
	call writefile(l:header, s:filename,)
endfunction

function! s:writecomment(string)
	call writefile(['" ' . a:string], s:filename, 'a')
endfunction

let s:common_colors = {
	\ '#000000':  16, '#00005F':  17, '#000087':  18, '#0000AF':  19, '#0000D7':  20,
	\ '#0000FF':  21, '#005F00':  22, '#005F5F':  23, '#005F87':  24, '#005FAF':  25,
	\ '#005FD7':  26, '#005FFF':  27, '#008700':  28, '#00875F':  29, '#008787':  30,
	\ '#0087AF':  31, '#0087D7':  32, '#0087FF':  33, '#00AF00':  34, '#00AF5F':  35,
	\ '#00AF87':  36, '#00AFAF':  37, '#00AFD7':  38, '#00AFFF':  39, '#00D700':  40,
	\ '#00D75F':  41, '#00D787':  42, '#00D7AF':  43, '#00D7D7':  44, '#00D7FF':  45,
	\ '#00FF00':  46, '#00FF5F':  47, '#00FF87':  48, '#00FFAF':  49, '#00FFD7':  50,
	\ '#00FFFF':  51, '#5F0000':  52, '#5F005F':  53, '#5F0087':  54, '#5F00AF':  55,
	\ '#5F00D7':  56, '#5F00FF':  57, '#5F5F00':  58, '#5F5F5F':  59, '#5F5F87':  60,
	\ '#5F5FAF':  61, '#5F5FD7':  62, '#5F5FFF':  63, '#5F8700':  64, '#5F875F':  65,
	\ '#5F8787':  66, '#5F87AF':  67, '#5F87D7':  68, '#5F87FF':  69, '#5FAF00':  70,
	\ '#5FAF5F':  71, '#5FAF87':  72, '#5FAFAF':  73, '#5FAFD7':  74, '#5FAFFF':  75,
	\ '#5FD700':  76, '#5FD75F':  77, '#5FD787':  78, '#5FD7AF':  79, '#5FD7D7':  80,
	\ '#5FD7FF':  81, '#5FFF00':  82, '#5FFF5F':  83, '#5FFF87':  84, '#5FFFAF':  85,
	\ '#5FFFD7':  86, '#5FFFFF':  87, '#870000':  88, '#87005F':  89, '#870087':  90,
	\ '#8700AF':  91, '#8700D7':  92, '#8700FF':  93, '#875F00':  94, '#875F5F':  95,
	\ '#875F87':  96, '#875FAF':  97, '#875FD7':  98, '#875FFF':  99, '#878700': 100,
	\ '#87875F': 101, '#878787': 102, '#8787AF': 103, '#8787D7': 104, '#8787FF': 105,
	\ '#87AF00': 106, '#87AF5F': 107, '#87AF87': 108, '#87AFAF': 109, '#87AFD7': 110,
	\ '#87AFFF': 111, '#87D700': 112, '#87D75F': 113, '#87D787': 114, '#87D7AF': 115,
	\ '#87D7D7': 116, '#87D7FF': 117, '#87FF00': 118, '#87FF5F': 119, '#87FF87': 120,
	\ '#87FFAF': 121, '#87FFD7': 122, '#87FFFF': 123, '#AF0000': 124, '#AF005F': 125,
	\ '#AF0087': 126, '#AF00AF': 127, '#AF00D7': 128, '#AF00FF': 129, '#AF5F00': 130,
	\ '#AF5F5F': 131, '#AF5F87': 132, '#AF5FAF': 133, '#AF5FD7': 134, '#AF5FFF': 135,
	\ '#AF8700': 136, '#AF875F': 137, '#AF8787': 138, '#AF87AF': 139, '#AF87D7': 140,
	\ '#AF87FF': 141, '#AFAF00': 142, '#AFAF5F': 143, '#AFAF87': 144, '#AFAFAF': 145,
	\ '#AFAFD7': 146, '#AFAFFF': 147, '#AFD700': 148, '#AFD75F': 149, '#AFD787': 150,
	\ '#AFD7AF': 151, '#AFD7D7': 152, '#AFD7FF': 153, '#AFFF00': 154, '#AFFF5F': 155,
	\ '#AFFF87': 156, '#AFFFAF': 157, '#AFFFD7': 158, '#AFFFFF': 159, '#D70000': 160,
	\ '#D7005F': 161, '#D70087': 162, '#D700AF': 163, '#D700D7': 164, '#D700FF': 165,
	\ '#D75F00': 166, '#D75F5F': 167, '#D75F87': 168, '#D75FAF': 169, '#D75FD7': 170,
	\ '#D75FFF': 171, '#D78700': 172, '#D7875F': 173, '#D78787': 174, '#D787AF': 175,
	\ '#D787D7': 176, '#D787FF': 177, '#D7AF00': 178, '#D7AF5F': 179, '#D7AF87': 180,
	\ '#D7AFAF': 181, '#D7AFD7': 182, '#D7AFFF': 183, '#D7D700': 184, '#D7D75F': 185,
	\ '#D7D787': 186, '#D7D7AF': 187, '#D7D7D7': 188, '#D7D7FF': 189, '#D7FF00': 190,
	\ '#D7FF5F': 191, '#D7FF87': 192, '#D7FFAF': 193, '#D7FFD7': 194, '#D7FFFF': 195,
	\ '#FF0000': 196, '#FF005F': 197, '#FF0087': 198, '#FF00AF': 199, '#FF00D7': 200,
	\ '#FF00FF': 201, '#FF5F00': 202, '#FF5F5F': 203, '#FF5F87': 204, '#FF5FAF': 205,
	\ '#FF5FD7': 206, '#FF5FFF': 207, '#FF8700': 208, '#FF875F': 209, '#FF8787': 210,
	\ '#FF87AF': 211, '#FF87D7': 212, '#FF87FF': 213, '#FFAF00': 214, '#FFAF5F': 215,
	\ '#FFAF87': 216, '#FFAFAF': 217, '#FFAFD7': 218, '#FFAFFF': 219, '#FFD700': 220,
	\ '#FFD75F': 221, '#FFD787': 222, '#FFD7AF': 223, '#FFD7D7': 224, '#FFD7FF': 225,
	\ '#FFFF00': 226, '#FFFF5F': 227, '#FFFF87': 228, '#FFFFAF': 229, '#FFFFD7': 230,
	\ '#FFFFFF': 231, '#080808': 232, '#121212': 233, '#1C1C1C': 234, '#262626': 235,
	\ '#303030': 236, '#3A3A3A': 237, '#444444': 238, '#4E4E4E': 239, '#585858': 240,
	\ '#626262': 241, '#6C6C6C': 242, '#767676': 243, '#808080': 244, '#8A8A8A': 245,
	\ '#949494': 246, '#9E9E9E': 247, '#A8A8A8': 248, '#B2B2B2': 249, '#BCBCBC': 250,
	\ '#C6C6C6': 251, '#D0D0D0': 252, '#DADADA': 253, '#E4E4E4': 254, '#EEEEEE': 255,
\}
" function, color is \'<html color value>\'
function! s:color_dist(color1, color2)
	let l:r1 = ('0x' . strpart(a:color1, 1, 3)) + 0
	let l:g1 = ('0x' . strpart(a:color1, 3, 3)) + 0
	let l:b1 = ('0x' . strpart(a:color1, 5, 3)) + 0

	let l:r2 = ('0x' . strpart(a:color2, 1, 3)) + 0
	let l:g2 = ('0x' . strpart(a:color2, 3, 3)) + 0
	let l:b2 = ('0x' . strpart(a:color2, 5, 3)) + 0

	let l:dr = l:r1 - l:r2
	let l:dg = l:g1 - l:g2
	let l:db = l:b1 - l:b2

	return (l:dr*l:dr) + (l:dg*l:dg) + (l:db*l:db)
endfunction

" function, color is \'#<html color value>\'
function! s:GetClosestTermColor(color)
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
function! s:AppendColorToFile(key, dict)
	if has_key(a:dict, 'FG')
		let l:guifg = a:dict['FG']
		let l:ctermfg = s:GetClosestTermColor(a:dict['FG'])
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
			let l:ctermbg = s:GetClosestTermColor(a:dict['BG'])
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
	for i in range(50 - len(l:name))
		let l:name ..= ' '
	endfor
	let line = 'highlight ' . l:name . ' guifg='. l:guifg . ' guibg=' . l:guibg . ' ctermfg=' . l:ctermfg . ' ctermbg=' . l:ctermbg . ' term=' . l:special . ' gui=' . l:special
	call writefile([line], s:filename, 'a')
endfunction

function! s:AppendLinkToFile(cF, cT)
	let l:nameF = a:cF
	for i in range(24 - len(l:nameF))
		let l:nameF ..= ' '
	endfor
	call writefile(['highlight! link ' . l:nameF . ' ' . a:cT], s:filename, 'a')
endfunction

let s:CP = {}

" UI related colors
let s:CP.AccentFg          = '#d5d5e0'
let s:CP.AccentBg          = '#2166a6'
let s:CP.ViewFg            = '#d5d5e0'
let s:CP.ViewBg            = '#18181A'
let s:CP.MidViewFg         = '#b2b2b2'
let s:CP.MidViewBg         = '#101013'
let s:CP.DarkViewFg        = '#a8a8a8'
let s:CP.DarkViewBg        = '#0C0C0C'
let s:CP.ObjFg             = '#b2b2b2'
let s:CP.ObjBg             = '#2B2B3B'
let s:CP.SelectedObjFg     = '#d2d2d2'
let s:CP.SelectedObjBg     = '#4B4B4B'
let s:CP.NonText           = '#585858'
let s:CP.LimitLines        = '#34343a'
let s:CP.ViewHint          = '#202028'
let s:CP.Special           = '#5fafff'
let s:CP.InfoFg            = '#585858'
let s:CP.InfoBg            = '#2a2a2a'
let s:CP.ErrSym            = '#a70000'
let s:CP.WarSym            = '#b7af5f'
let s:CP.InfoSym           = '#658beb'
let s:CP.HintSym           = '#e4e4e4'
let s:CP.DiffAdd           = '#73C991'
let s:CP.DiffChange        = '#D7BA7D'
let s:CP.DiffDelete        = '#94151b'
let s:CP.VisualSelection   = '#263e76'
let s:CP.SearchHighlight   = '#263e76'
let s:CP.SearchSelected    = '#724325'
let s:CP.ErrorMsg          = '#F44747'
" Code related colors
let s:CP.Comment           = '#5f875f'
let s:CP.String            = '#C38872'
let s:CP.Number            = '#afd7af'
let s:CP.Boolean           = '#af87d7'
let s:CP.Type              = '#5fafaf'
let s:CP.Keyword           = '#87afff'
let s:CP.Operator          = '#af5f87'
let s:CP.Repeat            = '#C586C0'
let s:CP.Conditional       = '#af87d7'
let s:CP.Include           = '#d75f87'
let s:CP.Object            = '#e4e4e4'
let s:CP.Field             = '#c4e4ff'
let s:CP.Constant          = '#e7e89f'
let s:CP.Function          = '#e8e6b5'

let s:BaseColorscheme = {}
let s:BaseColorscheme.Accent                                 = { 'FG':s:CP.AccentBg, }
let s:BaseColorscheme.Normal                                 = { 'FG':s:CP.ViewFg,            'BG':s:CP.ViewBg, }
let s:BaseColorscheme.NormalFloat                            = { 'FG':s:CP.ViewFg,            'BG':s:CP.ViewBg, }
let s:BaseColorscheme.Include                                = { 'FG':s:CP.Include, }
let s:BaseColorscheme.Comment                                = { 'FG':s:CP.Comment, }
let s:BaseColorscheme.Constant                               = { 'FG':s:CP.Constant, }
let s:BaseColorscheme.Delimiter                              = { 'FG':s:CP.ViewFg,            'BG':s:CP.ViewBg, }
let s:BaseColorscheme.String                                 = { 'FG':s:CP.String, }
let s:BaseColorscheme.Character                              = { 'FG':s:CP.String, }
let s:BaseColorscheme.Boolean                                = { 'FG':s:CP.Boolean, }
let s:BaseColorscheme.Number                                 = { 'FG':s:CP.Number, }
let s:BaseColorscheme.Float                                  = { 'FG':s:CP.Number, }
let s:BaseColorscheme.Repeat                                 = { 'FG':s:CP.Repeat, }
let s:BaseColorscheme.Conditional                            = { 'FG':s:CP.Conditional, }
let s:BaseColorscheme.Keyword                                = { 'FG':s:CP.Keyword, }
let s:BaseColorscheme.Operator                               = { 'FG':s:CP.Operator, }
let s:BaseColorscheme.Function                               = { 'FG':s:CP.Function, }
let s:BaseColorscheme.Identifier                             = { 'FG':s:CP.Object, }
let s:BaseColorscheme.Field                                  = { 'FG':s:CP.Field, }
let s:BaseColorscheme.Type                                   = { 'FG':s:CP.Type, }
let s:BaseColorscheme.Directory                              = { 'FG':s:CP.Special, }
let s:BaseColorscheme.Error                                  = { 'FG':s:CP.ErrorMsg,          'S':'bold', }
let s:BaseColorscheme.Special                                = { 'FG':s:CP.Special, }
let s:BaseColorscheme.Folded                                 = { 'FG':s:CP.Special,           'BG':s:CP.NonText, }
let s:BaseColorscheme.StatusLine                             = { 'FG':s:CP.AccentFg,          'BG':s:CP.AccentBg, }
let s:BaseColorscheme.StatusLineNC                           = { 'FG':s:CP.ObjFg,             'BG':s:CP.ObjBg, }
let s:BaseColorscheme.Pmenu                                  = { 'FG':s:CP.ObjFg,             'BG':s:CP.ObjBg, }
let s:BaseColorscheme.PmenuSel                               = { 'FG':s:CP.SelectedObjFg,     'BG':s:CP.SelectedObjBg, }
let s:BaseColorscheme.PmenuSbar                              = { 'BG':s:CP.LimitLines, }
let s:BaseColorscheme.PmenuThumb                             = { 'BG':s:CP.SelectedObjBg, }
let s:BaseColorscheme.TabLineSel                             = { 'FG':s:CP.ViewFg,            'BG':s:CP.ViewBg, }
let s:BaseColorscheme.TabLine                                = { 'FG':s:CP.MidViewFg,        'BG':s:CP.MidViewBg, }
let s:BaseColorscheme.TabLineFill                            = { 'BG':s:CP.DarkViewBg, }
let s:BaseColorscheme.WildMenu                               = { 'FG':s:CP.ObjFg,             'BG':s:CP.ObjBg, }
let s:BaseColorscheme.LineNr                                 = { 'FG':s:CP.ObjFg, }
let s:BaseColorscheme.ModeMsg                                = { 'FG':s:CP.ObjFg, }
let s:BaseColorscheme.SignColumn                             = { 'BG':s:CP.ViewBg, }
let s:BaseColorscheme.CursorLineNr                           = { 'FG':s:CP.AccentFg, }
let s:BaseColorscheme.CursorLine                             = { 'BG':s:CP.ViewHint, }
let s:BaseColorscheme.CursorColumn                           = { 'BG':s:CP.ViewHint, }
let s:BaseColorscheme.ColorColumn                            = { 'BG':s:CP.ViewHint, }
let s:BaseColorscheme.Cursor                                 = { 'S':'Reverse', }
let s:BaseColorscheme.VertSplit                              = { 'FG':s:CP.LimitLines, }
let s:BaseColorscheme.WinSeparator                           = { 'FG':s:CP.LimitLines, }
let s:BaseColorscheme.Search                                 = { 'BG':s:CP.SearchHighlight, }
let s:BaseColorscheme.IncSearch                              = { 'BG':s:CP.SearchSelected, }
let s:BaseColorscheme.Visual                                 = { 'BG':s:CP.VisualSelection, }
let s:BaseColorscheme.VisualNOS                              = { 'FG':s:CP.ObjFg, }
let s:BaseColorscheme.NonText                                = { 'FG':s:CP.NonText, }
let s:BaseColorscheme.SpecialKey                             = { 'FG':s:CP.ObjFg, }
let s:BaseColorscheme.DiffAdd                                = { 'FG':s:CP.DiffAdd, }
let s:BaseColorscheme.DiffChange                             = { 'FG':s:CP.DiffChange, }
let s:BaseColorscheme.DiffDelete                             = { 'FG':s:CP.DiffDelete, }
let s:BaseColorscheme.DiagnosticSignError                    = { 'FG':s:CP.ErrSym, }
let s:BaseColorscheme.DiagnosticSignWarning                  = { 'FG':s:CP.WarSym, }
let s:BaseColorscheme.DiagnosticSignInformation              = { 'FG':s:CP.InfoSym, }
let s:BaseColorscheme.DiagnosticSignInfo                     = { 'FG':s:CP.InfoSym, }
let s:BaseColorscheme.DiagnosticSignHint                     = { 'FG':s:CP.HintSym, }

let s:FtdeviconsColorscheme = {}
let s:FtdeviconsColorscheme.ftdeviconsBrown       = { 'FG':'#875F5F' }
let s:FtdeviconsColorscheme.ftdeviconsAqua        = { 'FG':'#5FFFD7' }
let s:FtdeviconsColorscheme.ftdeviconsBlue        = { 'FG':'#005f87' }
let s:FtdeviconsColorscheme.ftdeviconsDarkBlue    = { 'FG':'#005fd7' }
let s:FtdeviconsColorscheme.ftdeviconsPurple      = { 'FG':'#875F87' }
let s:FtdeviconsColorscheme.ftdeviconsRed         = { 'FG':'#af0000' }
let s:FtdeviconsColorscheme.ftdeviconsYellow      = { 'FG':'#FFD700' }
let s:FtdeviconsColorscheme.ftdeviconsOrange      = { 'FG':'#FFAF5F' }
let s:FtdeviconsColorscheme.ftdeviconsPink        = { 'FG':'#FF5F87' }
let s:FtdeviconsColorscheme.ftdeviconsSalmon      = { 'FG':'#D75F5F' }
let s:FtdeviconsColorscheme.ftdeviconsGreen       = { 'FG':'#87AF5F' }
let s:FtdeviconsColorscheme.ftdeviconsLightGreen  = { 'FG':'#5FAF5F' }
let s:FtdeviconsColorscheme.ftdeviconsGrey        = { 'FG':'#b2b2b2' }
let s:FtdeviconsColorscheme.ftdeviconsWhite       = { 'FG':'#FFFFFF' }

let s:TablineColorscheme = {}
" Base tab color
let s:TablineColorscheme.TabLineSel                             = { 'FG':s:CP.ViewFg,                                        'BG':s:CP.ViewBg, }
let s:TablineColorscheme.TabLine                                = { 'FG':s:CP.MidViewFg,                                     'BG':s:CP.MidViewBg, }
let s:TablineColorscheme.TabLineFill                            = { 'BG':s:CP.DarkViewBg, }
" Hints
let s:TablineColorscheme.TabLineSelHint                         = { 'FG':'#4C4C5F', 'BG':s:TablineColorscheme.TabLineSel['BG'], }
let s:TablineColorscheme.TabLineHint                            = { 'FG':'#343441', 'BG':s:TablineColorscheme.TabLine['BG'], }
" Seperators
let s:TablineColorscheme.TabLineSelSep                          = { 'FG':s:CP.ViewBg,                                        'BG':s:TablineColorscheme.TabLineFill['BG'], }
let s:TablineColorscheme.TabLineSep                             = { 'FG':s:CP.MidViewBg,                                     'BG':s:TablineColorscheme.TabLineFill['BG'], }
" Active diagnostics
let s:TablineColorscheme.TablinediagnosticActiveSignError       = { 'FG':'#A70000',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablinediagnosticActiveSignWarn        = { 'FG':'#B7AF5F',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablinediagnosticActiveSignInfo        = { 'FG':'#658BEB',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablinediagnosticActiveSignHint        = { 'FG':'#E4E4E4',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
" Inactive diagnostics
let s:TablineColorscheme.TablinediagnosticInactiveSignError     = { 'FG':'#890000',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablinediagnosticInactiveSignWarn      = { 'FG':'#99924F',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablinediagnosticInactiveSignInfo      = { 'FG':'#587BCD',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablinediagnosticInactiveSignHint      = { 'FG':'#C6C6C6',      'BG':s:TablineColorscheme.TabLine['BG'] }
" Active ftdevicons
let s:TablineColorscheme.TablineftdeviconsActiveBrown           = { 'FG':'#875F5F',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActiveAqua            = { 'FG':'#5FFFD7',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActiveBlue            = { 'FG':'#005f87',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActiveDarkBlue        = { 'FG':'#005fd7',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActivePurple          = { 'FG':'#875F87',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActiveRed             = { 'FG':'#af0000',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActiveYellow          = { 'FG':'#FFD700',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActiveOrange          = { 'FG':'#FFAF5F',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActivePink            = { 'FG':'#FF5F87',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActiveSalmon          = { 'FG':'#D75F5F',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActiveGreen           = { 'FG':'#87AF5F',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActiveLightGreen      = { 'FG':'#5FAF5F',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActiveGrey            = { 'FG':'#b2b2b2',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
let s:TablineColorscheme.TablineftdeviconsActiveWhite           = { 'FG':'#FFFFFF',      'BG':s:TablineColorscheme.TabLineSel['BG'] }
" Inactive ftdevicons
let s:TablineColorscheme.TablineftdeviconsInactiveBrown         = { 'FG':'#694a4a',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactiveAqua          = { 'FG':'#54e1be',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactiveBlue          = { 'FG':'#004b69',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactiveDarkBlue      = { 'FG':'#005fd7',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactivePurple        = { 'FG':'#694a69',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactiveRed           = { 'FG':'#910000',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactiveYellow        = { 'FG':'#e1bc00',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactiveOrange        = { 'FG':'#e19a54',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactivePink          = { 'FG':'#e15477',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactiveSalmon        = { 'FG':'#b95252',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactiveGreen         = { 'FG':'#70914e',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactiveLightGreen    = { 'FG':'#4e914e',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactiveGrey          = { 'FG':'#949494',      'BG':s:TablineColorscheme.TabLine['BG'] }
let s:TablineColorscheme.TablineftdeviconsInactiveWhite         = { 'FG':'#e1e1e1',      'BG':s:TablineColorscheme.TabLine['BG'] }

let s:BaseLinks = {
\'Title'          : 'Normal',
\'Todo'           : 'Special',
\'Statement'      : 'Repeat',
\'SpecialComment' : 'Special', 
\'CursorColumn'   : 'CursorLine',
\'String'         : 'Character',
\}

let s:DiagnosticLinks = {
\'LspDiagnosticsDefaultError'             : 'DiagnosticSignError',
\'LspDiagnosticsDefaultWarning'           : 'DiagnosticSignWarning',
\'LspDiagnosticsDefaultInformation'       : 'DiagnosticSignInformation',
\'LspDiagnosticsDefaultInfo'              : 'DiagnosticSignInfo',
\'LspDiagnosticsDefaultHint'              : 'DiagnosticSignHint',
\'LspDiagnosticsVirtualTextError'         : 'DiagnosticSignError',
\'LspDiagnosticsVirtualTextWarning'       : 'DiagnosticSignWarning',
\'LspDiagnosticsVirtualTextInformation'   : 'DiagnosticSignInformation',
\'LspDiagnosticsVirtualTextInfo'          : 'DiagnosticSignInfo',
\'LspDiagnosticsVirtualTextHint'          : 'DiagnosticSignHint',
\'LspDiagnosticsFloatingError'            : 'DiagnosticSignError',
\'LspDiagnosticsFloatingWarning'          : 'DiagnosticSignWarning',
\'LspDiagnosticsFloatingInformation'      : 'DiagnosticSignInformation',
\'LspDiagnosticsFloatingInfo'             : 'DiagnosticSignInfo',
\'LspDiagnosticsFloatingHint'             : 'DiagnosticSignHint',
\'LspDiagnosticsSignError'                : 'DiagnosticSignError',
\'LspDiagnosticsSignWarning'              : 'DiagnosticSignWarning',
\'LspDiagnosticsSignInformation'          : 'DiagnosticSignInformation',
\'LspDiagnosticsSignInfo'                 : 'DiagnosticSignInfo',
\'LspDiagnosticsSignHint'                 : 'DiagnosticSignHint',
\'LspDiagnosticsError'                    : 'DiagnosticSignError',
\'LspDiagnosticsWarning'                  : 'DiagnosticSignWarning',
\'LspDiagnosticsInformation'              : 'DiagnosticSignInformation',
\'LspDiagnosticsInfo'                     : 'DiagnosticSignInfo',
\'LspDiagnosticsHint'                     : 'DiagnosticSignHint',
\'LspDiagnosticsUnderlineError'           : 'DiagnosticSignError',
\'LspDiagnosticsUnderlineWarning'         : 'DiagnosticSignWarning',
\'LspDiagnosticsUnderlineInformation'     : 'DiagnosticSignInformation',
\'LspDiagnosticsUnderlineInfo'            : 'DiagnosticSignInfo',
\'LspDiagnosticsUnderlineHint'            : 'DiagnosticSignHint',
\}

let s:VimLinks = {
\'vimEnvvar'       : 'Constant',
\'vimHiKeyList'    : 'Constant',
\'vimCommand'      : 'Keyword',
\'vimUsrCmd'       : 'Keyword',
\'vimIsCommand'    : 'Keyword',
\'vimNotFunc'      : 'Keyword',
\'vimUserFunc'     : 'Function',
\'vimCommentTitle' : 'Special', 
\}

let s:JsonLinks = {
\'jsonKeyword' : 'Keyword',
\'jsonBoolean' : 'Boolean',
\}

let s:TreesitterLinks = {
\'TSString'             : 'String',
\'TSOperator'           : 'Operator',
\'TSFunction'           : 'Function',
\'TSFuncBuiltin'        : 'Function',
\'TSFuncMacro'          : 'Function',
\'TSError'              : 'Error',
\'TSPunctDelimiter'     : 'PunctDelimiter',
\'TSPunctBracket'       : 'PunctBracket',
\'TSPunctSpecial'       : 'PunctSpecial',
\'TSConstant'           : 'Constant',
\'TSConstBuiltin'       : 'Constant',
\'TSConstMacro'         : 'Type',
\'TSStringRegex'        : 'String',
\'TSStringEscape'       : 'Operator',
\'TSCharacter'          : 'String',
\'TSNumber'             : 'Number',
\'TSBoolean'            : 'Boolean',
\'TSFloat'              : 'Float',
\'TSAnnotation'         : 'Comment',
\'TSAttribute'          : 'Attribute',
\'TSNamespace'          : 'Namespace',
\'TSParameter'          : 'Identifier',
\'TSParameterReference' : 'Identifier',
\'TSMethod'             : 'Function',
\'TSField'              : 'Field',
\'TSProperty'           : 'Property',
\'TSConstructor'        : 'Constructor',
\'TSConditional'        : 'Conditional',
\'TSRepeat'             : 'Repeat',
\'TSLabel'              : 'Label',
\'TSKeyword'            : 'Keyword',
\'TSKeywordFunction'    : 'Keyword',
\'TSKeywordOperator'    : 'Keyword',
\'TSException'          : 'Exception',
\'TSType'               : 'Type',
\'TSTypeBuiltin'        : 'Type',
\'TSStructure'          : 'Type',
\'TSInclude'            : 'Include',
\'TSVariable'           : 'Identifier',
\'TSVariableBuiltin'    : 'Identifier',
\'TSText'               : 'Normal',
\'TSStrong'             : 'Strong',
\'TSEmphasis'           : 'Emphasis',
\'TSUnderline'          : 'Underline',
\'TSTitle'              : 'Title',
\'TSLiteral'            : 'Literal',
\'TSURI'                : 'Identifier',
\'TSTag'                : 'Tag',
\'TSTagDelimiter'       : 'TagDelimiter',
\}

call s:WriteColorschemeHeader()
call s:writecomment('" This file was genereated with ' .. s:this_script_path .. ' file')
call s:writecomment('-------------- Cplex highlights --------------')
for [key, value] in items(s:BaseColorscheme) | call s:AppendColorToFile(key, value) | endfor
call s:writecomment('-------------- Devicons highlights --------------')
for [key, value] in items(s:FtdeviconsColorscheme) | call s:AppendColorToFile(key, value) | endfor
call s:writecomment('-------------- Tabline highlights --------------')
for [key, value] in items(s:TablineColorscheme) | call s:AppendColorToFile(key, value) | endfor
call s:writecomment('-------------- General links --------------')
for [key, value] in items(s:BaseLinks) | call s:AppendLinkToFile(key, value) | endfor
call s:writecomment('-------------- Vim links --------------')
for [key, value] in items(s:VimLinks) | call s:AppendLinkToFile(key, value) | endfor
call s:writecomment('-------------- JSON links --------------')
for [key, value] in items(s:JsonLinks) | call s:AppendLinkToFile(key, value) | endfor
call s:writecomment('-------------- Treesitter links --------------')
for [key, value] in items(s:TreesitterLinks) | call s:AppendLinkToFile(key, value) | endfor
