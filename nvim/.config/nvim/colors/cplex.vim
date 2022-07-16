" cplex colorscheme header
set background=dark
highlight clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name = "cplex"
" Hints for panels
highlight PanelHint guifg=#4c4c5f guibg=NONE ctermfg=239 ctermbg=NONE term=NONE gui=NONE
" General colors
highlight Accent guifg=#2166a6 guibg=NONE ctermfg=25 ctermbg=NONE term=NONE gui=NONE
highlight Normal guifg=#d5d5e0 guibg=#18181a ctermfg=253 ctermbg=234 term=NONE gui=NONE
highlight Float guifg=#d5d5e0 guibg=#18181a ctermfg=253 ctermbg=234 term=NONE gui=NONE
highlight Include guifg=#d75f87 guibg=NONE ctermfg=168 ctermbg=NONE term=NONE gui=NONE
highlight Comment guifg=#5f875f guibg=NONE ctermfg=65 ctermbg=NONE term=NONE gui=NONE
highlight Constant guifg=#e7e89f guibg=NONE ctermfg=187 ctermbg=NONE term=NONE gui=NONE
highlight Delimiter guifg=#d5d5e0 guibg=#18181a ctermfg=253 ctermbg=234 term=NONE gui=NONE
highlight String guifg=#c38872 guibg=NONE ctermfg=173 ctermbg=NONE term=NONE gui=NONE
highlight Character guifg=#c38872 guibg=NONE ctermfg=173 ctermbg=NONE term=NONE gui=NONE
highlight Boolean guifg=#af87d7 guibg=NONE ctermfg=140 ctermbg=NONE term=NONE gui=NONE
highlight Number guifg=#afd7af guibg=NONE ctermfg=151 ctermbg=NONE term=NONE gui=NONE
highlight Float guifg=#afd7af guibg=NONE ctermfg=151 ctermbg=NONE term=NONE gui=NONE
highlight Repeat guifg=#c586c0 guibg=NONE ctermfg=175 ctermbg=NONE term=NONE gui=NONE
highlight Conditional guifg=#af87d7 guibg=NONE ctermfg=140 ctermbg=NONE term=NONE gui=NONE
highlight Keyword guifg=#87afff guibg=NONE ctermfg=111 ctermbg=NONE term=NONE gui=NONE
highlight Operator guifg=#af5f87 guibg=NONE ctermfg=132 ctermbg=NONE term=NONE gui=NONE
highlight Function guifg=#e8e6b5 guibg=NONE ctermfg=187 ctermbg=NONE term=NONE gui=NONE
highlight Identifier guifg=#e4e4e4 guibg=NONE ctermfg=254 ctermbg=NONE term=NONE gui=NONE
highlight Field guifg=#c4e4ff guibg=NONE ctermfg=189 ctermbg=NONE term=NONE gui=NONE
highlight Type guifg=#5fafaf guibg=NONE ctermfg=73 ctermbg=NONE term=NONE gui=NONE
highlight Directory guifg=#5fafff guibg=NONE ctermfg=75 ctermbg=NONE term=NONE gui=NONE
highlight Error guifg=#f44747 guibg=NONE ctermfg=203 ctermbg=NONE term=bold gui=bold
highlight Special guifg=#5fafff guibg=NONE ctermfg=75 ctermbg=NONE term=NONE gui=NONE
highlight Folded guifg=#5fafff guibg=#585858 ctermfg=75 ctermbg=240 term=NONE gui=NONE
highlight StatusLine guifg=#d5d5e0 guibg=#2166a6 ctermfg=253 ctermbg=25 term=NONE gui=NONE
highlight StatusLineNC guifg=#b2b2b2 guibg=#2b2b3b ctermfg=249 ctermbg=236 term=NONE gui=NONE
highlight StatusLineSep guifg=#2166a6 guibg=#2b2b3b ctermfg=25 ctermbg=236 term=NONE gui=NONE
highlight Pmenu guifg=#b2b2b2 guibg=#2b2b3b ctermfg=249 ctermbg=236 term=NONE gui=NONE
highlight PmenuSel guifg=#d2d2d2 guibg=#4b4b4b ctermfg=252 ctermbg=239 term=NONE gui=NONE
highlight PmenuSbar guifg=NONE guibg=#34343a ctermfg=NONE ctermbg=237 term=NONE gui=NONE
highlight PmenuThumb guifg=NONE guibg=#4b4b4b ctermfg=NONE ctermbg=239 term=NONE gui=NONE
highlight TabLineSel guifg=#d5d5e0 guibg=#18181a ctermfg=253 ctermbg=234 term=NONE gui=NONE
highlight TabLineSelSep guifg=#18181a guibg=#0c0c0c ctermfg=234 ctermbg=232 term=NONE gui=NONE
highlight TabLine guifg=#b2b2b2 guibg=#101013 ctermfg=249 ctermbg=233 term=NONE gui=NONE
highlight TabLineFill guifg=NONE guibg=#0c0c0c ctermfg=NONE ctermbg=232 term=NONE gui=NONE
highlight TabLineSep guifg=#101013 guibg=#0c0c0c ctermfg=233 ctermbg=232 term=NONE gui=NONE
highlight WildMenu guifg=#b2b2b2 guibg=#2b2b3b ctermfg=249 ctermbg=236 term=NONE gui=NONE
highlight LineNr guifg=#b2b2b2 guibg=NONE ctermfg=249 ctermbg=NONE term=NONE gui=NONE
highlight ModeMsg guifg=#b2b2b2 guibg=NONE ctermfg=249 ctermbg=NONE term=NONE gui=NONE
highlight SignColumn guifg=NONE guibg=#18181a ctermfg=NONE ctermbg=234 term=NONE gui=NONE
highlight CursorLineNr guifg=#d5d5e0 guibg=NONE ctermfg=253 ctermbg=NONE term=NONE gui=NONE
highlight CursorLine guifg=NONE guibg=#202028 ctermfg=NONE ctermbg=235 term=NONE gui=NONE
highlight CursorColumn guifg=NONE guibg=#202028 ctermfg=NONE ctermbg=235 term=NONE gui=NONE
highlight ColorColumn guifg=NONE guibg=#202028 ctermfg=NONE ctermbg=235 term=NONE gui=NONE
highlight Cursor guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=Reverse gui=Reverse
highlight VertSplit guifg=#34343a guibg=NONE ctermfg=237 ctermbg=NONE term=NONE gui=NONE
highlight WinSeparator guifg=#34343a guibg=NONE ctermfg=237 ctermbg=NONE term=NONE gui=NONE
highlight Search guifg=NONE guibg=#263e76 ctermfg=NONE ctermbg=24 term=NONE gui=NONE
highlight IncSearch guifg=NONE guibg=#724325 ctermfg=NONE ctermbg=58 term=NONE gui=NONE
highlight Visual guifg=NONE guibg=#263e76 ctermfg=NONE ctermbg=24 term=NONE gui=NONE
highlight VisualNOS guifg=#b2b2b2 guibg=NONE ctermfg=249 ctermbg=NONE term=NONE gui=NONE
highlight NonText guifg=#585858 guibg=NONE ctermfg=240 ctermbg=NONE term=NONE gui=NONE
highlight SpecialKey guifg=#b2b2b2 guibg=NONE ctermfg=249 ctermbg=NONE term=NONE gui=NONE
highlight DiffAdd guifg=#83c99a guibg=NONE ctermfg=114 ctermbg=NONE term=NONE gui=NONE
highlight DiffChange guifg=#d7bf8e guibg=NONE ctermfg=180 ctermbg=NONE term=NONE gui=NONE
highlight DiffDelete guifg=#942126 guibg=NONE ctermfg=88 ctermbg=NONE term=NONE gui=NONE
highlight DiagnosticSignError guifg=#a70000 guibg=NONE ctermfg=124 ctermbg=NONE term=NONE gui=NONE
highlight DiagnosticSignWarning guifg=#b7af5f guibg=NONE ctermfg=143 ctermbg=NONE term=NONE gui=NONE
highlight DiagnosticSignInformation guifg=#658beb guibg=NONE ctermfg=69 ctermbg=NONE term=NONE gui=NONE
highlight DiagnosticSignInfo guifg=#658beb guibg=NONE ctermfg=69 ctermbg=NONE term=NONE gui=NONE
highlight DiagnosticSignHint guifg=#e4e4e4 guibg=NONE ctermfg=254 ctermbg=NONE term=NONE gui=NONE
" Specific colors (mainly for devicons)
highlight c_000000 guifg=#000000 guibg=NONE ctermfg=16 ctermbg=NONE term=NONE gui=NONE
highlight c_005CA5 guifg=#005CA5 guibg=NONE ctermfg=25 ctermbg=NONE term=NONE gui=NONE
highlight c_0061FE guifg=#0061FE guibg=NONE ctermfg=27 ctermbg=NONE term=NONE gui=NONE
highlight c_019833 guifg=#019833 guibg=NONE ctermfg=29 ctermbg=NONE term=NONE gui=NONE
highlight c_03589C guifg=#03589C guibg=NONE ctermfg=25 ctermbg=NONE term=NONE gui=NONE
highlight c_1563FF guifg=#1563FF guibg=NONE ctermfg=27 ctermbg=NONE term=NONE gui=NONE
highlight c_185ABD guifg=#185ABD guibg=NONE ctermfg=25 ctermbg=NONE term=NONE gui=NONE
highlight c_207245 guifg=#207245 guibg=NONE ctermfg=23 ctermbg=NONE term=NONE gui=NONE
highlight c_31B53E guifg=#31B53E guibg=NONE ctermfg=71 ctermbg=NONE term=NONE gui=NONE
highlight c_358A5B guifg=#358A5B guibg=NONE ctermfg=65 ctermbg=NONE term=NONE gui=NONE
highlight c_384D54 guifg=#384D54 guibg=NONE ctermfg=238 ctermbg=NONE term=NONE gui=NONE
highlight c_3D6117 guifg=#3D6117 guibg=NONE ctermfg=58 ctermbg=NONE term=NONE gui=NONE
highlight c_41535B guifg=#41535B guibg=NONE ctermfg=239 ctermbg=NONE term=NONE gui=NONE
highlight c_427819 guifg=#427819 guibg=NONE ctermfg=64 ctermbg=NONE term=NONE gui=NONE
highlight c_42A5F5 guifg=#42A5F5 guibg=NONE ctermfg=75 ctermbg=NONE term=NONE gui=NONE
highlight c_519ABA guifg=#519ABA guibg=NONE ctermfg=67 ctermbg=NONE term=NONE gui=NONE
highlight c_51A0CF guifg=#51A0CF guibg=NONE ctermfg=74 ctermbg=NONE term=NONE gui=NONE
highlight c_563D7C guifg=#563D7C guibg=NONE ctermfg=60 ctermbg=NONE term=NONE gui=NONE
highlight c_596706 guifg=#596706 guibg=NONE ctermfg=58 ctermbg=NONE term=NONE gui=NONE
highlight c_599EFF guifg=#599EFF guibg=NONE ctermfg=75 ctermbg=NONE term=NONE gui=NONE
highlight c_6D8086 guifg=#6D8086 guibg=NONE ctermfg=66 ctermbg=NONE term=NONE gui=NONE
highlight c_701516 guifg=#701516 guibg=NONE ctermfg=52 ctermbg=NONE term=NONE gui=NONE
highlight c_7EBAE4 guifg=#7EBAE4 guibg=NONE ctermfg=110 ctermbg=NONE term=NONE gui=NONE
highlight c_854CC7 guifg=#854CC7 guibg=NONE ctermfg=98 ctermbg=NONE term=NONE gui=NONE
highlight c_87C095 guifg=#87C095 guibg=NONE ctermfg=108 ctermbg=NONE term=NONE gui=NONE
highlight c_89E051 guifg=#89E051 guibg=NONE ctermfg=113 ctermbg=NONE term=NONE gui=NONE
highlight c_8DC149 guifg=#8DC149 guibg=NONE ctermfg=107 ctermbg=NONE term=NONE gui=NONE
highlight c_9772FB guifg=#9772FB guibg=NONE ctermfg=99 ctermbg=NONE term=NONE gui=NONE
highlight c_A074C4 guifg=#A074C4 guibg=NONE ctermfg=140 ctermbg=NONE term=NONE gui=NONE
highlight c_A270BA guifg=#A270BA guibg=NONE ctermfg=133 ctermbg=NONE term=NONE gui=NONE
highlight c_B30B00 guifg=#B30B00 guibg=NONE ctermfg=124 ctermbg=NONE term=NONE gui=NONE
highlight c_B83998 guifg=#B83998 guibg=NONE ctermfg=132 ctermbg=NONE term=NONE gui=NONE
highlight c_BBBBBB guifg=#BBBBBB guibg=NONE ctermfg=250 ctermbg=NONE term=NONE gui=NONE
highlight c_CB4A32 guifg=#CB4A32 guibg=NONE ctermfg=167 ctermbg=NONE term=NONE gui=NONE
highlight c_CC3E44 guifg=#CC3E44 guibg=NONE ctermfg=167 ctermbg=NONE term=NONE gui=NONE
highlight c_D0BF41 guifg=#D0BF41 guibg=NONE ctermfg=179 ctermbg=NONE term=NONE gui=NONE
highlight c_DEA584 guifg=#DEA584 guibg=NONE ctermfg=180 ctermbg=NONE term=NONE gui=NONE
highlight c_E24329 guifg=#E24329 guibg=NONE ctermfg=166 ctermbg=NONE term=NONE gui=NONE
highlight c_E34C26 guifg=#E34C26 guibg=NONE ctermfg=166 ctermbg=NONE term=NONE gui=NONE
highlight c_E37933 guifg=#E37933 guibg=NONE ctermfg=173 ctermbg=NONE term=NONE gui=NONE
highlight c_E44D26 guifg=#E44D26 guibg=NONE ctermfg=166 ctermbg=NONE term=NONE gui=NONE
highlight c_E4B854 guifg=#E4B854 guibg=NONE ctermfg=179 ctermbg=NONE term=NONE gui=NONE
highlight c_E8274B guifg=#E8274B guibg=NONE ctermfg=161 ctermbg=NONE term=NONE gui=NONE
highlight c_ECECEC guifg=#ECECEC guibg=NONE ctermfg=255 ctermbg=NONE term=NONE gui=NONE
highlight c_F14C28 guifg=#F14C28 guibg=NONE ctermfg=202 ctermbg=NONE term=NONE gui=NONE
highlight c_F1E05A guifg=#F1E05A guibg=NONE ctermfg=221 ctermbg=NONE term=NONE gui=NONE
highlight c_F55385 guifg=#F55385 guibg=NONE ctermfg=204 ctermbg=NONE term=NONE gui=NONE
highlight c_F69A1B guifg=#F69A1B guibg=NONE ctermfg=208 ctermbg=NONE term=NONE gui=NONE
highlight c_F88A02 guifg=#F88A02 guibg=NONE ctermfg=208 ctermbg=NONE term=NONE gui=NONE
highlight c_FAF743 guifg=#FAF743 guibg=NONE ctermfg=227 ctermbg=NONE term=NONE gui=NONE
highlight c_FB9D3B guifg=#FB9D3B guibg=NONE ctermfg=215 ctermbg=NONE term=NONE gui=NONE
highlight c_FF3E00 guifg=#FF3E00 guibg=NONE ctermfg=202 ctermbg=NONE term=NONE gui=NONE
highlight c_FFA61A guifg=#FFA61A guibg=NONE ctermfg=214 ctermbg=NONE term=NONE gui=NONE
highlight c_FFAFAF guifg=#FFAFAF guibg=NONE ctermfg=217 ctermbg=NONE term=NONE gui=NONE
highlight c_FFB13B guifg=#FFB13B guibg=NONE ctermfg=215 ctermbg=NONE term=NONE gui=NONE
highlight c_FFE291 guifg=#FFE291 guibg=NONE ctermfg=222 ctermbg=NONE term=NONE gui=NONE
highlight c_FFFFFF guifg=#FFFFFF guibg=NONE ctermfg=231 ctermbg=NONE term=NONE gui=NONE
" Normal links
highlight! link Title Normal
highlight! link Todo Special
highlight! link Statement Repeat
highlight! link SpecialComment Special
highlight! link CursorColumn CursorLine
highlight! link String Character
" Lsp links
highlight! link LspDiagnosticsDefaultError DiagnosticSignError
highlight! link LspDiagnosticsDefaultWarning DiagnosticSignWarning
highlight! link LspDiagnosticsDefaultInformation DiagnosticSignInformation
highlight! link LspDiagnosticsDefaultInfo DiagnosticSignInfo
highlight! link LspDiagnosticsDefaultHint DiagnosticSignHint
highlight! link LspDiagnosticsVirtualTextError DiagnosticSignError
highlight! link LspDiagnosticsVirtualTextWarning DiagnosticSignWarning
highlight! link LspDiagnosticsVirtualTextInformation DiagnosticSignInformation
highlight! link LspDiagnosticsVirtualTextInfo DiagnosticSignInfo
highlight! link LspDiagnosticsVirtualTextHint DiagnosticSignHint
highlight! link LspDiagnosticsFloatingError DiagnosticSignError
highlight! link LspDiagnosticsFloatingWarning DiagnosticSignWarning
highlight! link LspDiagnosticsFloatingInformation DiagnosticSignInformation
highlight! link LspDiagnosticsFloatingInfo DiagnosticSignInfo
highlight! link LspDiagnosticsFloatingHint DiagnosticSignHint
highlight! link LspDiagnosticsSignError DiagnosticSignError
highlight! link LspDiagnosticsSignWarning DiagnosticSignWarning
highlight! link LspDiagnosticsSignInformation DiagnosticSignInformation
highlight! link LspDiagnosticsSignInfo DiagnosticSignInfo
highlight! link LspDiagnosticsSignHint DiagnosticSignHint
highlight! link LspDiagnosticsError DiagnosticSignError
highlight! link LspDiagnosticsWarning DiagnosticSignWarning
highlight! link LspDiagnosticsInformation DiagnosticSignInformation
highlight! link LspDiagnosticsInfo DiagnosticSignInfo
highlight! link LspDiagnosticsHint DiagnosticSignHint
highlight! link LspDiagnosticsUnderlineError DiagnosticSignError
highlight! link LspDiagnosticsUnderlineWarning DiagnosticSignWarning
highlight! link LspDiagnosticsUnderlineInformation DiagnosticSignInformation
highlight! link LspDiagnosticsUnderlineInfo DiagnosticSignInfo
highlight! link LspDiagnosticsUnderlineHint DiagnosticSignHint
" Viml links
highlight! link vimEnvvar Constant
highlight! link vimHiKeyList Constant
highlight! link vimCommand Keyword
highlight! link vimUsrCmd Keyword
highlight! link vimIsCommand Keyword
highlight! link vimNotFunc Keyword
highlight! link vimUserFunc Function
highlight! link vimCommentTitle Special
" Json links
highlight! link jsonKeyword Keyword
highlight! link jsonBoolean Boolean
" Treesitter links
highlight! link TSString String
highlight! link TSOperator Operator
highlight! link TSFunction Function
highlight! link TSFuncBuiltin Function
highlight! link TSFuncMacro Function
highlight! link TSError Error
highlight! link TSPunctDelimiter PunctDelimiter
highlight! link TSPunctBracket PunctBracket
highlight! link TSPunctSpecial PunctSpecial
highlight! link TSConstant Constant
highlight! link TSConstBuiltin Constant
highlight! link TSConstMacro Type
highlight! link TSStringRegex String
highlight! link TSStringEscape Operator
highlight! link TSCharacter String
highlight! link TSNumber Number
highlight! link TSBoolean Boolean
highlight! link TSFloat Float
highlight! link TSAnnotation Comment
highlight! link TSAttribute Attribute
highlight! link TSNamespace Namespace
highlight! link TSParameter Identifier
highlight! link TSParameterReference Identifier
highlight! link TSMethod Function
highlight! link TSField Field
highlight! link TSProperty Property
highlight! link TSConstructor Constructor
highlight! link TSConditional Conditional
highlight! link TSRepeat Repeat
highlight! link TSLabel Label
highlight! link TSKeyword Keyword
highlight! link TSKeywordFunction Keyword
highlight! link TSKeywordOperator Keyword
highlight! link TSException Exception
highlight! link TSType Type
highlight! link TSTypeBuiltin Type
highlight! link TSStructure Type
highlight! link TSInclude Include
highlight! link TSVariable Identifier
highlight! link TSVariableBuiltin Identifier
highlight! link TSText Normal
highlight! link TSStrong Strong
highlight! link TSEmphasis Emphasis
highlight! link TSUnderline Underline
highlight! link TSTitle Title
highlight! link TSLiteral Literal
highlight! link TSURI Identifier
highlight! link TSTag Tag
highlight! link TSTagDelimiter TagDelimiter
