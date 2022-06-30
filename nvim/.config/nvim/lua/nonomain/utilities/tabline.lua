local fn = vim.fn
local diagnostic = vim.diagnostic
local ftdevicons = require('nonomain/utilities/ftdevicons')
local M = {}

M.signs = {}
if vim.g.devicons then
M.diagnosticSymbols = {
	DiagnosticSignError = '',
	DiagnosticSignWarn = '',
	DiagnosticSignInfo = '',
	DiagnosticSignHint = '',
}
else
M.diagnosticSymbols = {
	DiagnosticSignError = 'E',
	DiagnosticSignWarn = 'W',
	DiagnosticSignInfo = '?',
	DiagnosticSignHint = 'I',
}
end
M.signs.ActiveTabSymbol = '○'
M.signs.InactiveTabSymbol = '×'
if vim.g.devicons then
	M.signs.LeftSep = '_'
	M.signs.RightSep = '_'
else
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

M.getBufferPath = function(tabnr)
	local bufnr = fn.tabpagebuflist(tabnr)[fn.tabpagewinnr(tabnr)]
	return fn.bufname(bufnr)
end

M.getBufferTitle = function(tabnr)
	local bufnr = fn.tabpagebuflist(tabnr)[fn.tabpagewinnr(tabnr)]
	local path = fn.bufname(bufnr)
	local buftype = vim.fn.getbufvar(bufnr, '&buftype')

	if path == '' then
		return '[No Name]'
	elseif buftype == 'terminal' then
		local _, match = string.match(path, "term:(.*):(%a+)")
		return 't:' .. (match ~= nil and match or vim.fn.fnamemodify(vim.env.SHELL, ':t'))
	elseif buftype == 'help' then
		return 'help:' .. vim.fn.fnamemodify(path, ':t:r')
	else
		return vim.fn.pathshorten(vim.fn.fnamemodify(path, ':~:t'))
	end
end

M.getActiveBuf = function(tabnr)
	local window = fn.tabpagewinnr(tabnr)
	return fn.tabpagebuflist(tabnr)[window]

end

M.getBufferDiagnostics = function(tabnr, is_active)
	local buffer = M.getActiveBuf(tabnr)
	local state = is_active and 'Active' or 'Inactive'
	local ret = ''
	local bd = {}
	local _, ec = pcall(diagnostic.get,buffer, { severity = vim.diagnostic.severity.ERROR })
	bd.ErrorCount = #(ec)
	local _, wc = pcall(diagnostic.get,buffer, { severity = vim.diagnostic.severity.WARN })
	bd.WarningCount = #(wc)
	local _, ic = pcall(diagnostic.get,buffer, { severity = vim.diagnostic.severity.INFO })
	bd.InfoCount = #(ic)
	local _, hc = pcall(diagnostic.get,buffer, { severity = vim.diagnostic.severity.HINT })
	bd.HintCount = #(hc)
	if bd.ErrorCount > 0 then   ret = ret .. '%#Tablinediagnostic' .. state .. 'SignError#' .. M.diagnosticSymbols.DiagnosticSignError .. ' ' end
	if bd.WarningCount > 0 then ret = ret .. '%#Tablinediagnostic' .. state .. 'SignWarn#' .. M.diagnosticSymbols.DiagnosticSignWarn .. ' ' end
	if bd.InfoCount > 0 then    ret = ret .. '%#Tablinediagnostic' .. state .. 'SignInfo#' .. M.diagnosticSymbols.DiagnosticSignInfo .. ' ' end
	if bd.HintCount > 0 then    ret = ret .. '%#Tablinediagnostic' .. state .. 'SignHint#' .. M.diagnosticSymbols.DiagnosticSignHint .. ' ' end
	return ret
end

M.getWindowCount = function(tab)
	local count = #(tab.windows)
	-- pretty one
	-- return count > 1 and fn.nr2char(fn.char2nr('❶') + count - 1) or ''
	-- normal one
	return count > 1 and ("") .. count or ''
end

M.generateLabel = function(tab, is_active)
	local windowCount = M.getWindowCount(tab)
	local path = M.getBufferPath(tab.tabnr)
	local title = M.getBufferTitle(tab.tabnr)
	local symbols = {}
	local highlights = {}
	if is_active then
		highlights.hint = '%#TabLineSelHint#'
	else
		highlights.hint = '%#TabLineHint#'
	end

	if vim.g.devicons then
		if path == '' then
			symbols.ftsymbol = ftdevicons.default_extentionSymbol
		else
			symbols.ftsymbol = ftdevicons.getFilenameSymbol(fn.fnamemodify(path, ':t')) or ftdevicons.getExtentionSymbol(fn.fnamemodify(path, ':e')) or ftdevicons.getDirectorySymbol('closed')
		end
	else
		symbols.ftsymbol = ''
		highlights.ftsymbol = ''
	end
	symbols.labelSymbol = ''
	if is_active then
		highlights.normal = '%#TabLineSel#'
		highlights.symbol = '%#TabLineSel#'
		highlights.seperator = '%#TabLineSelSep#'
		highlights.ftsymbol = '%#TablineftdeviconsActive' .. ftdevicons.getColorOfSymbol(symbols.ftsymbol) .. '#'
		symbols.labelSymbol = M.signs.ActiveTabSymbol
	else
		highlights.normal = '%#TabLine#'
		highlights.symbol = '%#TabLine#'
		highlights.seperator = '%#TabLineSep#'
		highlights.ftsymbol = '%#TablineftdeviconsInactive' .. ftdevicons.getColorOfSymbol(symbols.ftsymbol) .. '#'
		symbols.labelSymbol = M.signs.InactiveTabSymbol
	end
	local label = highlights.hint .. windowCount .. ' ' .. highlights.ftsymbol .. symbols.ftsymbol .. ' ' .. highlights.normal .. title .. ' ' .. M.getBufferDiagnostics(tab.tabnr, is_active) .. highlights.symbol .. M.insertCloseSign(tab.tabnr, symbols.labelSymbol)
	local comp_lable = highlights.seperator .. M.signs.LeftSep .. label .. highlights.seperator .. M.signs.RightSep
	return M.insertTab(tab.tabnr, comp_lable)
end

M.getOS = function()
	local os = ''
	if fn.has('unix') then
		local ok, distro = pcall(fn.system, 'lsb_release -i')
		if not ok then
			os = vim.g.devicons and ' ' or 'Linux'
		elseif string.find(distro, 'Ubuntu') ~= nil then
			os =  vim.g.devicons and ' ' or 'Ubuntu'
		elseif string.find(distro, 'Debian') ~= nil then
			os =  vim.g.devicons and ' ' or 'Debian'
		elseif string.find(distro, 'Arch') ~= nil then
			os =  vim.g.devicons and ' ' or 'Arch'
		elseif string.find(distro, 'Gentoo') ~= nil then
			os =  vim.g.devicons and ' ' or 'Gentoo'
		elseif string.find(distro, 'Cent') ~= nil then
			os =  vim.g.devicons and ' ' or 'CentOS'
		elseif string.find(distro, 'Dock') ~= nil then
			os =  vim.g.devicons and ' ' or 'Docker'
		else
			os = vim.g.devicons and ' ' or 'Linux'
		end
	elseif fn.has('win32') then
		os =  vim.g.devicons and ' ' or 'Windows'
	elseif fn.has('macunix') then
		os =  vim.g.devicons and ' ' or 'MacOS'
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
	tabline = tabline .. '%=%#TabLineFill#'
	tabline = tabline .. '%#Accent# ' .. M.getOS() .. ' '
	return tabline
end

M.enable = function()
	vim.opt.tabline='%!v:lua.require\'nonomain.utilities.tabline\'.tabline()'
end

M.disable = function()
	vim.opt.tabline=''
end

return {
	tabline = M.generateTabline,
	enable = M.enable,
	disable = M.disable,
}
