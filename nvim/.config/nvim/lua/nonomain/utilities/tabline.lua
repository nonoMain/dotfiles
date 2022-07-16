local fn = vim.fn
local ftdevicons = require("nonomain/utilities/ftdevicons")
local M = {}

M.signs = {}
if vim.g.devicons then
	-- M.signs.ActiveTabSymbol = '○'
	-- M.signs.InactiveTabSymbol = '×'
	M.signs.ActiveTabSymbol = '◉'
	M.signs.InactiveTabSymbol = '○'
	M.signs.LeftSep = " "
	M.signs.RightSep = " "
else
	M.signs.ActiveTabSymbol = '[x]'
	M.signs.InactiveTabSymbol = '[ ]'
	M.signs.LeftSep = ''
	M.signs.RightSep = ''
end

M.insertTab = function(tabnr, line)
	if #line == 0 then return '' end
	return '%' .. tabnr .. 'T' .. line .. '%T'
end

M.insertCloseSign = function(tabnr, line)
	if #line == 0 then return '' end
	return '%' .. tabnr .. 'X' .. line .. '%X'
end

M.getBufnr = function(tabnr)
	return fn.tabpagebuflist(tabnr)[fn.tabpagewinnr(tabnr)]
end

M.getBufferPath = function(bufnr)
	return fn.bufname(bufnr)
end

M.getBufferTitle = function(bufnr)
	local path = fn.bufname(bufnr)
	local buftype = fn.getbufvar(bufnr, "&buftype")
	local filetype = fn.getbufvar(bufnr, "&filetype")

	if filetype == "netrw" then
		return "netrw:" .. fn.fnamemodify(path, ":~:.")
	elseif buftype == "terminal" then
		local _, match = string.match(path, "term:(.*):(%a+)")
		return "t:" .. (match ~= nil and match or fn.fnamemodify(vim.env.SHELL, ":t"))
	elseif buftype == "quickfix" then
		return "quickfix"
	elseif buftype == "help" then
		return "help:" .. fn.fnamemodify(path, ":t:r")
	elseif filetype == "man" then
		return "man:" .. string.sub(path, 7)
	elseif filetype == "git" then
		return "Git"
	elseif filetype == "fugitive" then
		return "Fugitive"
	elseif filetype == "oldfilesBrowser" then
		return "old files"
	elseif path == '' then
		return "[No Name]"
	else
		return fn.pathshorten(fn.fnamemodify(path, ":~:t"))
	end
end

M.getBufferSymbol = function(bufnr)
	local buftype = fn.getbufvar(bufnr, "&buftype")
	local filetype = fn.getbufvar(bufnr, "&filetype")
	if filetype == "netrw" then
		return ' '
	elseif filetype == "man" then
		return '龎'
	elseif buftype == "quickfix" then
		return ''
	elseif buftype == "help" then
		return 'ﲉ'
	elseif filetype == "oldfilesBrowser" then
		return ''
	end
	return nil
end

M.getWindowCount = function(tab)
	local count = #(tab.windows)
	-- pretty one
	-- return count > 1 and fn.nr2char(fn.char2nr('❶') + count - 1) or ''
	-- normal one
	return count > 1 and ("") .. count or ''
end

M.generateLabel = function(tab, is_active)
	local bufnr = M.getBufnr(tab.tabnr)
	local windowCount = M.getWindowCount(tab)
	local path = M.getBufferPath(bufnr)
	local title = M.getBufferTitle(bufnr)
	local symbols = {}
	local highlights = {}

	symbols.ftsymbol = ''
	highlights.ftsymbol = ''
	highlights.hint = "%#PanelHint#"

	if vim.g.devicons then
		if M.getBufferSymbol(bufnr) == nil then
			symbols.ftsymbol = ftdevicons.getPathSymbol(path)
		else
			symbols.ftsymbol = M.getBufferSymbol(bufnr)
		end
	end
	symbols.labelSymbol = ''
	if is_active then
		highlights.normal = "%#TabLineSel#"
		highlights.symbol = "%#TabLineSel#"
		highlights.seperator = "%#TabLineSelSep#"
		if vim.g.devicons and ftdevicons.getColorOfSymbol(symbols.ftsymbol) then
			highlights.ftsymbol = "%#" .. ftdevicons.getColorOfSymbol(symbols.ftsymbol) .. '#'
		end
		symbols.labelSymbol = M.signs.ActiveTabSymbol
	else
		highlights.normal = "%#TabLine#"
		highlights.symbol = "%#TabLine#"
		highlights.seperator = "%#TabLineSep#"
		if vim.g.devicons and ftdevicons.getColorOfSymbol(symbols.ftsymbol) then
			highlights.ftsymbol = "%#" .. ftdevicons.getColorOfSymbol(symbols.ftsymbol) .. '#'
		end
		symbols.labelSymbol = M.signs.InactiveTabSymbol
	end
	local label = highlights.hint .. windowCount .. highlights.ftsymbol .. ' ' .. symbols.ftsymbol .. ' ' .. highlights.normal .. title .. ' ' .. highlights.symbol .. M.insertCloseSign(tab.tabnr, symbols.labelSymbol)
	local comp_lable = highlights.seperator .. M.signs.LeftSep .. label .. highlights.seperator .. M.signs.RightSep
	return M.insertTab(tab.tabnr, comp_lable)
end

M.getOS = function()
	local os = ''
	if fn.has("unix") then
		local ok, distro = pcall(fn.system, "lsb_release -i")
		if not ok then
			os = vim.g.devicons and " " or "Linux"
		elseif string.find(distro, "Ubuntu") ~= nil then
			os =  vim.g.devicons and " " or "Ubuntu"
		elseif string.find(distro, "Debian") ~= nil then
			os =  vim.g.devicons and " " or "Debian"
		elseif string.find(distro, "Arch") ~= nil then
			os =  vim.g.devicons and " " or "Arch"
		elseif string.find(distro, "Gentoo") ~= nil then
			os =  vim.g.devicons and " " or "Gentoo"
		elseif string.find(distro, "Cent") ~= nil then
			os =  vim.g.devicons and " " or "CentOS"
		elseif string.find(distro, "Dock") ~= nil then
			os =  vim.g.devicons and " " or "Docker"
		else
			os = vim.g.devicons and " " or "Linux"
		end
	elseif fn.has("win32") then
		os =  vim.g.devicons and " " or "Windows"
	elseif fn.has("macunix") then
		os =  vim.g.devicons and " " or "MacOS"
	end
	return os
end

M.generateTabline = function()
	local tabline = ""
	local tabs = fn.gettabinfo()
	local current_tab = fn.tabpagenr()

	-- generate lables
	for _, tab in pairs(tabs) do
		if tab.tabnr == current_tab then
			tabline = tabline .. M.generateLabel(tab, true)
		else
			tabline = tabline .. M.generateLabel(tab, false)
		end
	end
	-- end of the tabline
	tabline = tabline .. "%=%#TabLineFill#"
	tabline = tabline .. "%#TabLineSelSep#" .. M.signs.LeftSep
	tabline = tabline .. "%#Accent# " .. M.getOS() .. ' '
	return tabline
end

M.enable = function()
	vim.opt.tabline="%!v:lua.require(\"nonomain.utilities.tabline\").tabline()"
end

M.disable = function()
	vim.opt.tabline=''
end

return {
	tabline = M.generateTabline,
	enable = M.enable,
	disable = M.disable,
}
