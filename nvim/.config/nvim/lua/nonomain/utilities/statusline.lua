local fn = vim.fn
local api = vim.api
local util = require("nonomain/utilities/utils")
local ftdevicons = require("nonomain/utilities/ftdevicons")
local diagnostic = vim.diagnostic
-- local ftdevicons = require('nonomain/utilities/ftdevicons')
local M = {}

M.signs = {}
if vim.g.devicons then
	M.signs.branch = ''
	M.signs.LeftSep = ""
	M.signs.RightSep = ''
	M.diagnosticSymbols = {
		DiagnosticSignError = '',
		DiagnosticSignWarn = '',
		DiagnosticSignInfo = '',
		DiagnosticSignHint = '',
	}
else
	M.signs.branch = "git:"
	M.signs.LeftSep = ''
	M.signs.RightSep = ''
	M.diagnosticSymbols = {
		DiagnosticSignError = 'E',
		DiagnosticSignWarn = 'W',
		DiagnosticSignInfo = 'I',
		DiagnosticSignHint = 'H',
	}
end

M.getGitBranch = function()
	local maybe, branch = pcall(util.get_git_branch)
	if not maybe or branch == "" or branch == nil then
		return ""
	else
		return M.signs.branch .. ' ' .. branch
	end
end

M.getBufferSymbol = function()
	local bufnr = fn.bufnr()
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

M.getBufferDiagnostics = function()
	local buffer = fn.bufnr()
	local ret = ""
	local bd = {}
	local _, ec = pcall(diagnostic.get,buffer, { severity = vim.diagnostic.severity.ERROR })
	bd.ErrorCount = #(ec)
	local _, wc = pcall(diagnostic.get,buffer, { severity = vim.diagnostic.severity.WARN })
	bd.WarningCount = #(wc)
	local _, ic = pcall(diagnostic.get,buffer, { severity = vim.diagnostic.severity.INFO })
	bd.InfoCount = #(ic)
	local _, hc = pcall(diagnostic.get,buffer, { severity = vim.diagnostic.severity.HINT })
	bd.HintCount = #(hc)
	if bd.ErrorCount > 0 then   ret = ret .. bd.ErrorCount .. ' ' .. M.diagnosticSymbols.DiagnosticSignError .. ' ' end
	if bd.WarningCount > 0 then ret = ret .. bd.WarningCount .. ' ' .. M.diagnosticSymbols.DiagnosticSignWarn .. ' ' end
	if bd.InfoCount > 0 then    ret = ret .. bd.InfoCount .. ' ' .. M.diagnosticSymbols.DiagnosticSignInfo .. ' ' end
	if bd.HintCount > 0 then    ret = ret .. bd.HintCount .. ' ' .. M.diagnosticSymbols.DiagnosticSignHint .. ' ' end
	return ret
end

M.ActiveLine = function()
	M.highlights = {}
	M.highlights.accent = "%#StatusLine#"
	M.highlights.normal = "%#StatusLineNC#"
	M.highlights.seperator = "%#StatusLineSep#"
	local symbol = M.getBufferSymbol() or ftdevicons.getPathSymbol(fn.bufname()) or ""
	local stl = M.highlights.accent .. ' ' .. "b:%n" .. ' ' .. M.getGitBranch() .. ' '
	stl = stl .. M.highlights.seperator .. M.signs.LeftSep
	stl = stl .. M.highlights.normal .. "%=" .. symbol .. " %<%f %h%w%m%r%=" .. M.getBufferDiagnostics()
	stl = stl .. M.highlights.seperator .. M.signs.RightSep
	stl = stl .. M.highlights.accent .. ' '
	stl = stl .. "%-6.(%l,%c%V%) %P "
	return stl
end

-- active status line gets refreshed all the time
M.statusline = function()
	vim.wo.statusline = "%!v:lua.require\'nonomain.utilities.statusline\'.ActiveLine()"
end
M.statuslineNC = function()
	local symbol = M.getBufferSymbol() or ftdevicons.getPathSymbol(fn.bufname()) or ""
	local stl = " b:%n" .. ' ' .. M.getGitBranch() .. ' ' .. "%=" .. symbol .. " %<%f %h%w%m%r%=%-6.(%l,%c%V%) %P "
	vim.wo.statusline = stl
end
M.enable = function()
	api.nvim_create_augroup("Statusline", { clear = true })
	api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, { callback = M.statuslineNC , group = "Statusline"})
	api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, { callback = M.statusline , group = "Statusline"})
end
M.disable = function()
	api.nvim_del_augroup_by_name("Statusline")
	local tabs = fn.gettabinfo()
	for _, tab in pairs(tabs) do
		for _, window in pairs(tab.windows) do
			fn.setwinvar(window, "&statusline", '')
		end
	end
end

return {
	ActiveLine = M.ActiveLine,
	enable = M.enable,
	disable = M.disable,
}
