local i2cv = { 0, 95, 135, 175, 215, 255 }

local M = {}

M.colorscheme_name = "cplex"
M.colorscheme_background = "dark"
M.colorscheme_file = io.open(os.getenv("XDG_CONFIG_HOME") .. "/nvim/colors/" .. M.colorscheme_name .. ".vim", 'w')

M.v2ci = function(v)
	if v < 48 then
		return 0
	elseif v < 115 then
		return 1
	else
		return math.floor((v - 35) / 40)
	end
end

M.dist_square = function(A, B, C, a, b, c)
	return ((A-a)*(A-a) + (B-b)*(B-b) + (C-c)*(C-c))
end

M.rgb2x256 = function(r, g, b)
	local avg = (r + g + b) / 3
	-- each will range from 0 .. 5:
	local red_idx = M.v2ci(r)
	local green_idx = M.v2ci(g)
	local blue_idx = M.v2ci(b)
	-- Calculate the nearest 0-based color index at 16 .. 231
	local color_idx = (36 * red_idx) + (6 * green_idx) + blue_idx
	local gray_idx = 23
	if avg > 238 then
		gray_idx = 23
	else
		gray_idx = math.floor((avg - 3) / 10)
	end

	local cr = i2cv[red_idx + 1]
	local cg = i2cv[green_idx + 1]
	local cb = i2cv[blue_idx + 1]

	local gv = 8 + (10 * gray_idx)
	-- Return the one which is nearer to the original input rgb value
	local c_error = M.dist_square(cr, cg, cb, r, g, b)
	local g_error = M.dist_square(gv, gv, gv, r, g, b)
	if c_error <= g_error then
		return 16 + color_idx
	else
		return 232 + gray_idx
	end
end

M.hex2rgb = function(hex)
	hex = hex:gsub("#","")
	return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

M.generate_highlight_command = function(dict)
	if dict.sp == nil then dict.sp = "NONE" end

	if dict.fg == nil then dict.gfg = "NONE"; dict.tfg = "NONE"
	else dict.gfg = dict.fg; dict.tfg = M.rgb2x256(M.hex2rgb(dict.gfg))
	end

	if dict.bg == nil then dict.gbg = "NONE"; dict.tbg = "NONE"
	else dict.gbg = dict.bg; dict.tbg = M.rgb2x256(M.hex2rgb(dict.gbg))
	end


	local line = "highlight " .. dict.group .. " guifg=" .. dict.gfg .. " guibg=" .. dict.gbg .. " ctermfg=" .. dict.tfg .. " ctermbg=" .. dict.tbg .. " term=" .. dict.sp .. " gui=" .. dict.sp
	return line
end

M.generate_link_command = function(dict)
	return 'highlight! link ' .. dict.from .. ' ' .. dict.to
end

M.comment = function(note)
	return '" ' .. note
end

M.append = function(text)
	M.colorscheme_file:write(text)
end

M.appendln = function(text)
	M.append(text .. "\n")
end

M.header = function(name, bg)
	local header = M.comment(name .. " colorscheme header") .. '\n'
	header = header .. "set background=" .. bg .. '\n'
	header = header ..
[[
highlight clear
if exists("syntax_on")
	syntax reset
endif
]]
	header = header .. "let g:colors_name = \"" .. name .. "\"\n"
	return header
end

M.colors = {
-- UI colors
	AccentFg          = "#d5d5e0",
	AccentBg          = "#2166a6",
	ViewFg            = "#d5d5e0",
	ViewBg            = "#18181a",
	MidViewFg         = "#b2b2b2",
	MidViewBg         = "#101013",
	DarkViewFg        = "#a8a8a8",
	DarkViewBg        = "#0c0c0c",
	ObjFg             = "#b2b2b2",
	ObjBg             = "#2b2b3b",
	SelectedObjFg     = "#d2d2d2",
	SelectedObjBg     = "#4b4b4b",
	NonText           = "#585858",
	LimitLines        = "#34343a",
	ViewHint          = "#202028",
	PanelHint         = "#4c4c5f",
	Special           = "#5fafff",
	InfoFg            = "#585858",
	InfoBg            = "#2a2a2a",
	ErrSym            = "#a70000",
	WarSym            = "#b7af5f",
	InfoSym           = "#658beb",
	HintSym           = "#e4e4e4",
	DiffAdd           = "#83c99a",
	DiffChange        = "#d7bf8e",
	DiffDelete        = "#942126",
	VisualSelection   = "#263e76",
	SearchHighlight   = "#263e76",
	SearchSelected    = "#724325",
	ErrorMsg          = "#f44747",
-- Code colors
	Comment           = "#5f875f",
	String            = "#c38872",
	Number            = "#afd7af",
	Boolean           = "#af87d7",
	Type              = "#5fafaf",
	Keyword           = "#87afff",
	Operator          = "#af5f87",
	Repeat            = "#c586c0",
	Conditional       = "#af87d7",
	Include           = "#d75f87",
	Object            = "#e4e4e4",
	Field             = "#c4e4ff",
	Constant          = "#e7e89f",
	Function          = "#e8e6b5",
}

M.Colorscheme = {
	{ note = "Hints for panels" },
	{ group = "PanelHint",                             fg = M.colors.PanelHint },

	{ note = "General colors" },
	{ group = "Accent",                                fg = M.colors.AccentBg, },
	{ group = "Normal",                                fg = M.colors.ViewFg,            bg = M.colors.ViewBg, },
	{ group = "Float",                                 fg = M.colors.ViewFg,            bg = M.colors.ViewBg, },
	{ group = "Include",                               fg = M.colors.Include, },
	{ group = "Comment",                               fg = M.colors.Comment, },
	{ group = "Constant",                              fg = M.colors.Constant, },
	{ group = "Delimiter",                             fg = M.colors.ViewFg,            bg = M.colors.ViewBg, },
	{ group = "String",                                fg = M.colors.String, },
	{ group = "Character",                             fg = M.colors.String, },
	{ group = "Boolean",                               fg = M.colors.Boolean, },
	{ group = "Number",                                fg = M.colors.Number, },
	{ group = "Float",                                 fg = M.colors.Number, },
	{ group = "Repeat",                                fg = M.colors.Repeat, },
	{ group = "Conditional",                           fg = M.colors.Conditional, },
	{ group = "Keyword",                               fg = M.colors.Keyword, },
	{ group = "Operator",                              fg = M.colors.Operator, },
	{ group = "Function",                              fg = M.colors.Function, },
	{ group = "Identifier",                            fg = M.colors.Object, },
	{ group = "Field",                                 fg = M.colors.Field, },
	{ group = "Type",                                  fg = M.colors.Type, },
	{ group = "Directory",                             fg = M.colors.Special, },
	{ group = "Error",                                 fg = M.colors.ErrorMsg,          sp = "bold", },
	{ group = "Special",                               fg = M.colors.Special, },
	{ group = "Folded",                                fg = M.colors.Special,           bg = M.colors.NonText, },
	{ group = "StatusLine",                            fg = M.colors.AccentFg,          bg = M.colors.AccentBg, },
	{ group = "StatusLineNC",                          fg = M.colors.ObjFg,             bg = M.colors.ObjBg, },
	{ group = "StatusLineSep",                         fg = M.colors.AccentBg,          bg = M.colors.ObjBg, },
	{ group = "Pmenu",                                 fg = M.colors.ObjFg,             bg = M.colors.ObjBg, },
	{ group = "PmenuSel",                              fg = M.colors.SelectedObjFg,     bg = M.colors.SelectedObjBg, },
	{ group = "PmenuSbar",                             bg = M.colors.LimitLines, },
	{ group = "PmenuThumb",                            bg = M.colors.SelectedObjBg, },
	{ group = "TabLineSel",                            fg = M.colors.ViewFg,            bg = M.colors.ViewBg, },
	{ group = "TabLineSelSep",                         fg = M.colors.ViewBg,            bg = M.colors.DarkViewBg, },
	{ group = "TabLine",                               fg = M.colors.MidViewFg,         bg = M.colors.MidViewBg, },
	{ group = "TabLineFill",                           bg = M.colors.DarkViewBg, },
	{ group = "TabLineSep",                            fg = M.colors.MidViewBg,         bg = M.colors.DarkViewBg, },
	{ group = "WildMenu",                              fg = M.colors.ObjFg,             bg = M.colors.ObjBg, },
	{ group = "LineNr",                                fg = M.colors.ObjFg, },
	{ group = "ModeMsg",                               fg = M.colors.ObjFg, },
	{ group = "SignColumn",                            bg = M.colors.ViewBg, },
	{ group = "CursorLineNr",                          fg = M.colors.AccentFg, },
	{ group = "CursorLine",                            bg = M.colors.ViewHint, },
	{ group = "CursorColumn",                          bg = M.colors.ViewHint, },
	{ group = "ColorColumn",                           bg = M.colors.ViewHint, },
	{ group = "Cursor",                                sp = "Reverse", },
	{ group = "VertSplit",                             fg = M.colors.LimitLines, },
	{ group = "WinSeparator",                          fg = M.colors.LimitLines, },
	{ group = "Search",                                bg = M.colors.SearchHighlight, },
	{ group = "IncSearch",                             bg = M.colors.SearchSelected, },
	{ group = "Visual",                                bg = M.colors.VisualSelection, },
	{ group = "VisualNOS",                             fg = M.colors.ObjFg, },
	{ group = "NonText",                               fg = M.colors.NonText, },
	{ group = "SpecialKey",                            fg = M.colors.ObjFg, },
	{ group = "DiffAdd",                               fg = M.colors.DiffAdd, },
	{ group = "DiffChange",                            fg = M.colors.DiffChange, },
	{ group = "DiffDelete",                            fg = M.colors.DiffDelete, },
	{ group = "DiagnosticSignError",                   fg = M.colors.ErrSym, },
	{ group = "DiagnosticSignWarning",                 fg = M.colors.WarSym, },
	{ group = "DiagnosticSignInformation",             fg = M.colors.InfoSym, },
	{ group = "DiagnosticSignInfo",                    fg = M.colors.InfoSym, },
	{ group = "DiagnosticSignHint",                    fg = M.colors.HintSym, },

	{ note = "Specific colors (mainly for devicons)" },
	{ group = "c_000000",                              fg = "#000000", },
	{ group = "c_005CA5",                              fg = "#005CA5", },
	{ group = "c_0061FE",                              fg = "#0061FE", },
	{ group = "c_019833",                              fg = "#019833", },
	{ group = "c_03589C",                              fg = "#03589C", },
	{ group = "c_1563FF",                              fg = "#1563FF", },
	{ group = "c_185ABD",                              fg = "#185ABD", },
	{ group = "c_207245",                              fg = "#207245", },
	{ group = "c_31B53E",                              fg = "#31B53E", },
	{ group = "c_358A5B",                              fg = "#358A5B", },
	{ group = "c_384D54",                              fg = "#384D54", },
	{ group = "c_3D6117",                              fg = "#3D6117", },
	{ group = "c_41535B",                              fg = "#41535B", },
	{ group = "c_427819",                              fg = "#427819", },
	{ group = "c_42A5F5",                              fg = "#42A5F5", },
	{ group = "c_519ABA",                              fg = "#519ABA", },
	{ group = "c_51A0CF",                              fg = "#51A0CF", },
	{ group = "c_563D7C",                              fg = "#563D7C", },
	{ group = "c_596706",                              fg = "#596706", },
	{ group = "c_599EFF",                              fg = "#599EFF", },
	{ group = "c_6D8086",                              fg = "#6D8086", },
	{ group = "c_701516",                              fg = "#701516", },
	{ group = "c_7EBAE4",                              fg = "#7EBAE4", },
	{ group = "c_854CC7",                              fg = "#854CC7", },
	{ group = "c_87C095",                              fg = "#87C095", },
	{ group = "c_89E051",                              fg = "#89E051", },
	{ group = "c_8DC149",                              fg = "#8DC149", },
	{ group = "c_9772FB",                              fg = "#9772FB", },
	{ group = "c_A074C4",                              fg = "#A074C4", },
	{ group = "c_A270BA",                              fg = "#A270BA", },
	{ group = "c_B30B00",                              fg = "#B30B00", },
	{ group = "c_B83998",                              fg = "#B83998", },
	{ group = "c_BBBBBB",                              fg = "#BBBBBB", },
	{ group = "c_CB4A32",                              fg = "#CB4A32", },
	{ group = "c_CC3E44",                              fg = "#CC3E44", },
	{ group = "c_D0BF41",                              fg = "#D0BF41", },
	{ group = "c_DEA584",                              fg = "#DEA584", },
	{ group = "c_E24329",                              fg = "#E24329", },
	{ group = "c_E34C26",                              fg = "#E34C26", },
	{ group = "c_E37933",                              fg = "#E37933", },
	{ group = "c_E44D26",                              fg = "#E44D26", },
	{ group = "c_E4B854",                              fg = "#E4B854", },
	{ group = "c_E8274B",                              fg = "#E8274B", },
	{ group = "c_ECECEC",                              fg = "#ECECEC", },
	{ group = "c_F14C28",                              fg = "#F14C28", },
	{ group = "c_F1E05A",                              fg = "#F1E05A", },
	{ group = "c_F55385",                              fg = "#F55385", },
	{ group = "c_F69A1B",                              fg = "#F69A1B", },
	{ group = "c_F88A02",                              fg = "#F88A02", },
	{ group = "c_FAF743",                              fg = "#FAF743", },
	{ group = "c_FB9D3B",                              fg = "#FB9D3B", },
	{ group = "c_FF3E00",                              fg = "#FF3E00", },
	{ group = "c_FFA61A",                              fg = "#FFA61A", },
	{ group = "c_FFAFAF",                              fg = "#FFAFAF", },
	{ group = "c_FFB13B",                              fg = "#FFB13B", },
	{ group = "c_FFE291",                              fg = "#FFE291", },
	{ group = "c_FFFFFF",                              fg = "#FFFFFF", },
}

M.Links = {
	{ note = "Normal links" },
	{ from = "Title",                                  to = "Normal", },
	{ from = "Todo",                                   to = "Special", },
	{ from = "Statement",                              to = "Repeat", },
	{ from = "SpecialComment",                         to = "Special", },
	{ from = "CursorColumn",                           to = "CursorLine", },
	{ from = "String",                                 to = "Character", },

	{ note = "Lsp links" },
	{ from = "LspDiagnosticsDefaultError",             to = "DiagnosticSignError", },
	{ from = "LspDiagnosticsDefaultWarning",           to = "DiagnosticSignWarning", },
	{ from = "LspDiagnosticsDefaultInformation",       to = "DiagnosticSignInformation", },
	{ from = "LspDiagnosticsDefaultInfo",              to = "DiagnosticSignInfo", },
	{ from = "LspDiagnosticsDefaultHint",              to = "DiagnosticSignHint", },
	{ from = "LspDiagnosticsVirtualTextError",         to = "DiagnosticSignError", },
	{ from = "LspDiagnosticsVirtualTextWarning",       to = "DiagnosticSignWarning", },
	{ from = "LspDiagnosticsVirtualTextInformation",   to = "DiagnosticSignInformation", },
	{ from = "LspDiagnosticsVirtualTextInfo",          to = "DiagnosticSignInfo", },
	{ from = "LspDiagnosticsVirtualTextHint",          to = "DiagnosticSignHint", },
	{ from = "LspDiagnosticsFloatingError",            to = "DiagnosticSignError", },
	{ from = "LspDiagnosticsFloatingWarning",          to = "DiagnosticSignWarning", },
	{ from = "LspDiagnosticsFloatingInformation",      to = "DiagnosticSignInformation", },
	{ from = "LspDiagnosticsFloatingInfo",             to = "DiagnosticSignInfo", },
	{ from = "LspDiagnosticsFloatingHint",             to = "DiagnosticSignHint", },
	{ from = "LspDiagnosticsSignError",                to = "DiagnosticSignError", },
	{ from = "LspDiagnosticsSignWarning",              to = "DiagnosticSignWarning", },
	{ from = "LspDiagnosticsSignInformation",          to = "DiagnosticSignInformation", },
	{ from = "LspDiagnosticsSignInfo",                 to = "DiagnosticSignInfo", },
	{ from = "LspDiagnosticsSignHint",                 to = "DiagnosticSignHint", },
	{ from = "LspDiagnosticsError",                    to = "DiagnosticSignError", },
	{ from = "LspDiagnosticsWarning",                  to = "DiagnosticSignWarning", },
	{ from = "LspDiagnosticsInformation",              to = "DiagnosticSignInformation", },
	{ from = "LspDiagnosticsInfo",                     to = "DiagnosticSignInfo", },
	{ from = "LspDiagnosticsHint",                     to = "DiagnosticSignHint", },
	{ from = "LspDiagnosticsUnderlineError",           to = "DiagnosticSignError", },
	{ from = "LspDiagnosticsUnderlineWarning",         to = "DiagnosticSignWarning", },
	{ from = "LspDiagnosticsUnderlineInformation",     to = "DiagnosticSignInformation", },
	{ from = "LspDiagnosticsUnderlineInfo",            to = "DiagnosticSignInfo", },
	{ from = "LspDiagnosticsUnderlineHint",            to = "DiagnosticSignHint", },

	{ note = "Viml links" },
	{ from = "vimEnvvar",                              to = "Constant", },
	{ from = "vimHiKeyList",                           to = "Constant", },
	{ from = "vimCommand",                             to = "Keyword", },
	{ from = "vimUsrCmd",                              to = "Keyword", },
	{ from = "vimIsCommand",                           to = "Keyword", },
	{ from = "vimNotFunc",                             to = "Keyword", },
	{ from = "vimUserFunc",                            to = "Function", },
	{ from = "vimCommentTitle",                        to = "Special", },

	{ note = "Json links" },
	{ from = "jsonKeyword",                            to = "Keyword", },
	{ from = "jsonBoolean",                            to = "Boolean", },

	{ note = "Treesitter links" },
	{ from = "TSString",                               to = "String", },
	{ from = "TSOperator",                             to = "Operator", },
	{ from = "TSFunction",                             to = "Function", },
	{ from = "TSFuncBuiltin",                          to = "Function", },
	{ from = "TSFuncMacro",                            to = "Function", },
	{ from = "TSError",                                to = "Error", },
	{ from = "TSPunctDelimiter",                       to = "PunctDelimiter", },
	{ from = "TSPunctBracket",                         to = "PunctBracket", },
	{ from = "TSPunctSpecial",                         to = "PunctSpecial", },
	{ from = "TSConstant",                             to = "Constant", },
	{ from = "TSConstBuiltin",                         to = "Constant", },
	{ from = "TSConstMacro",                           to = "Type", },
	{ from = "TSStringRegex",                          to = "String", },
	{ from = "TSStringEscape",                         to = "Operator", },
	{ from = "TSCharacter",                            to = "String", },
	{ from = "TSNumber",                               to = "Number", },
	{ from = "TSBoolean",                              to = "Boolean", },
	{ from = "TSFloat",                                to = "Float", },
	{ from = "TSAnnotation",                           to = "Comment", },
	{ from = "TSAttribute",                            to = "Attribute", },
	{ from = "TSNamespace",                            to = "Namespace", },
	{ from = "TSParameter",                            to = "Identifier", },
	{ from = "TSParameterReference",                   to = "Identifier", },
	{ from = "TSMethod",                               to = "Function", },
	{ from = "TSField",                                to = "Field", },
	{ from = "TSProperty",                             to = "Property", },
	{ from = "TSConstructor",                          to = "Constructor", },
	{ from = "TSConditional",                          to = "Conditional", },
	{ from = "TSRepeat",                               to = "Repeat", },
	{ from = "TSLabel",                                to = "Label", },
	{ from = "TSKeyword",                              to = "Keyword", },
	{ from = "TSKeywordFunction",                      to = "Keyword", },
	{ from = "TSKeywordOperator",                      to = "Keyword", },
	{ from = "TSException",                            to = "Exception", },
	{ from = "TSType",                                 to = "Type", },
	{ from = "TSTypeBuiltin",                          to = "Type", },
	{ from = "TSStructure",                            to = "Type", },
	{ from = "TSInclude",                              to = "Include", },
	{ from = "TSVariable",                             to = "Identifier", },
	{ from = "TSVariableBuiltin",                      to = "Identifier", },
	{ from = "TSText",                                 to = "Normal", },
	{ from = "TSStrong",                               to = "Strong", },
	{ from = "TSEmphasis",                             to = "Emphasis", },
	{ from = "TSUnderline",                            to = "Underline", },
	{ from = "TSTitle",                                to = "Title", },
	{ from = "TSLiteral",                              to = "Literal", },
	{ from = "TSURI",                                  to = "Identifier", },
	{ from = "TSTag",                                  to = "Tag", },
	{ from = "TSTagDelimiter",                         to = "TagDelimiter", },
}

M.append(M.header(M.colorscheme_name, M.colorscheme_background))

for _, highlight_dict in ipairs(M.Colorscheme) do
	if highlight_dict.note ~= nil then
		M.appendln(M.comment(highlight_dict.note))
	else
		M.appendln(M.generate_highlight_command(highlight_dict))
	end
end

for _, link_dict in ipairs(M.Links) do
	if link_dict.note ~= nil then
		M.appendln(M.comment(link_dict.note))
	else
		M.appendln(M.generate_link_command(link_dict))
	end
end

return M
