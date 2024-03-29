local i2cv = { 0, 95, 135, 175, 215, 255 }

local M = {}

M.colorscheme_name = "cplex"
M.filetype = "lua" -- write the colorscheme in lua (default)
-- M.filetype = "vim" -- write the colorscheme in vimscript

M.colorscheme_path = os.getenv("XDG_CONFIG_HOME") .. "/nvim/colors/" .. M.colorscheme_name
if M.filetype == "vim" then
	M.colorscheme_path = M.colorscheme_path .. ".vim"
else
	M.colorscheme_path = M.colorscheme_path .. ".lua"
end

M.colorscheme_file = io.open(M.colorscheme_path, 'w')

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
	if dict.reverse == nil then dict.reverse = false end
	if dict.bold == nil then dict.bold = false end

	if dict.fg == nil then
		if M.filetype == "vim" then
			dict.gfg = "NONE"; dict.tfg = "NONE"
		else
			dict.gfg = "none"; dict.tfg = "'none'"
		end
	else dict.gfg = dict.fg; dict.tfg = M.rgb2x256(M.hex2rgb(dict.gfg))
	end

	if dict.bg == nil then
		if M.filetype == "vim" then
			dict.gbg = "NONE"; dict.tbg = "NONE"
		else
			dict.gbg = "none"; dict.tbg = "'none'"
		end
	else dict.gbg = dict.bg; dict.tbg = M.rgb2x256(M.hex2rgb(dict.gbg))
	end

	local line = ""
	if M.filetype == "vim" then -- use sp

		dict.sp = "" -- create the gui / cterm field for vimscript
		if dict.reverse == true then dict.sp = dict.sp .. "reverse," end
		if dict.bold == true then dict.sp = dict.sp .. "bold," end
		if dict.sp == "" then dict.sp = "NONE" end

		line = line .. "highlight " .. dict.group .. " guifg=" .. dict.gfg .. " guibg=" .. dict.gbg .. " ctermfg=" .. dict.tfg .. " ctermbg=" .. dict.tbg .. " cterm=" .. dict.sp .. " gui=" .. dict.sp
	else -- lua -> use boolean args (no need for cterm / gui)
		line = line .. "vim.api.nvim_set_hl" .. "(0, '" .. dict.group .. "', {" .. " fg = '" .. dict.gfg .. "'" .. ", bg = '" .. dict.gbg .. "'" .. ", ctermfg = " .. dict.tfg .. ", ctermbg = " .. dict.tbg
		if dict.reverse == true then line = line .. ", reverse = true" end
		if dict.bold == true then line = line .. ", bold = true" end
		line = line .. "})"
	end
	return line
end

M.generate_link_command = function(dict)
	if M.filetype == "vim" then
		return 'highlight! link ' .. dict.from .. ' ' .. dict.to
	else
		return "vim.api.nvim_set_hl" .. "(0, '" .. dict.from .. "'" .. ", { link = '" .. dict.to .. "'})"
	end
end

M.comment = function(note)
	if M.filetype == "vim" then
		return '" ' .. note
	else
		return '-- ' .. note
	end
end

M.append = function(text)
	M.colorscheme_file:write(text)
end

M.appendln = function(text)
	M.append(text .. "\n")
end

M.header = function(name)
	local header = M.comment(name .. " colorscheme header") .. '\n'
	if M.filetype == "vim" then
		header = header .. "let g:colors_name = \"" .. name .. "\"\n"
	else
		header = header .. "vim.g.colors_name = \"" .. name .. "\"\n"
	end
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
	{ note = "Hints for panels" }, -- notice the note
	{ group = "PanelHint",                             fg = M.colors.PanelHint },

	{ note = "General colors" }, -- notice the note
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
	{ group = "Error",                                 fg = M.colors.ErrorMsg,          bold = true, },
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
	{ group = "Cursor",                                reverse = true, },
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

	{ note = "Specific colors (mainly for devicons)" }, -- notice the note
	{ group = "c_F14C28",                              fg = "#F14C28", },
	{ group = "c_019833",                              fg = "#019833", },
	{ group = "c_DEA584",                              fg = "#DEA584", },
	{ group = "c_E44D26",                              fg = "#E44D26", },
	{ group = "c_F69A1B",                              fg = "#F69A1B", },
	{ group = "c_9772FB",                              fg = "#9772FB", },
	{ group = "c_E8274B",                              fg = "#E8274B", },
	{ group = "c_F1E05A",                              fg = "#F1E05A", },
	{ group = "c_1563FF",                              fg = "#1563FF", },
	{ group = "c_185ABD",                              fg = "#185ABD", },
	{ group = "c_41535B",                              fg = "#41535B", },
	{ group = "c_B83998",                              fg = "#B83998", },
	{ group = "c_E34C26",                              fg = "#E34C26", },
	{ group = "c_358A5B",                              fg = "#358A5B", },
	{ group = "c_427819",                              fg = "#427819", },
	{ group = "c_563D7C",                              fg = "#563D7C", },
	{ group = "c_599EFF",                              fg = "#599EFF", },
	{ group = "c_CC3E44",                              fg = "#CC3E44", },
	{ group = "c_F88A02",                              fg = "#F88A02", },
	{ group = "c_FFA61A",                              fg = "#FFA61A", },
	{ group = "c_E4B854",                              fg = "#E4B854", },
	{ group = "c_D0BF41",                              fg = "#D0BF41", },
	{ group = "c_6D8086",                              fg = "#6D8086", },
	{ group = "c_A074C4",                              fg = "#A074C4", },
	{ group = "c_E37933",                              fg = "#E37933", },
	{ group = "c_8DC149",                              fg = "#8DC149", },
	{ group = "c_ECECEC",                              fg = "#ECECEC", },
	{ group = "c_51A0CF",                              fg = "#51A0CF", },
}

M.Links = {
	{ note = "Normal links" }, -- notice the note
	{ from = "Title",                                  to = "Normal", },
	{ from = "Todo",                                   to = "Special", },
	{ from = "Statement",                              to = "Repeat", },
	{ from = "SpecialComment",                         to = "Special", },
	{ from = "CursorColumn",                           to = "CursorLine", },
	{ from = "String",                                 to = "Character", },

	{ note = "Lsp links" }, -- notice the note
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

	{ note = "Viml links" }, -- notice the note
	{ from = "vimEnvvar",                              to = "Constant", },
	{ from = "vimHiKeyList",                           to = "Constant", },
	{ from = "vimCommand",                             to = "Keyword", },
	{ from = "vimUsrCmd",                              to = "Keyword", },
	{ from = "vimIsCommand",                           to = "Keyword", },
	{ from = "vimNotFunc",                             to = "Keyword", },
	{ from = "vimUserFunc",                            to = "Function", },
	{ from = "vimCommentTitle",                        to = "Special", },

	{ note = "Json links" }, -- notice the note
	{ from = "jsonKeyword",                            to = "Keyword", },
	{ from = "jsonBoolean",                            to = "Boolean", },

	{ note = "Treesitter links" }, -- notice the note
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

M.append(M.header(M.colorscheme_name))

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
