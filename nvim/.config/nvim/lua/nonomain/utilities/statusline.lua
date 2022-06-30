local fn = vim.fn
local api = vim.api
local git = require('nonomain/utilities/git')
local diagnostic = vim.diagnostic
-- local ftdevicons = require('nonomain/utilities/ftdevicons')
local M = {}

M.signs = {}
if vim.g.devicons then
	M.signs.branch = ''
	M.signs.LeftSep = ' '
	M.signs.RightSep = ''
	M.diagnosticSymbols = {
		DiagnosticSignError = '',
		DiagnosticSignWarn = '',
		DiagnosticSignInfo = '',
		DiagnosticSignHint = '',
	}
else
	M.signs.branch = 'git:'
	M.signs.LeftSep = ''
	M.signs.RightSep = ''
	M.diagnosticSymbols = {
		DiagnosticSignError = 'E',
		DiagnosticSignWarn = 'W',
		DiagnosticSignInfo = '?',
		DiagnosticSignHint = 'I',
	}
end

M.getGitBranch = function()
	local maybe, branch = pcall(git.branch)
	if not maybe or #branch == 0 or branch == nil then
		return ''
	else
		return M.signs.branch .. ' ' .. branch
	end
end

M.getBufferDiagnostics = function()
	local buffer = fn.bufnr()
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
	if bd.ErrorCount > 0 then   ret = ret .. '%#StatusLineHint#' .. bd.ErrorCount .. ' ' .. '%#StatuslinediagnosticSignError#' .. M.diagnosticSymbols.DiagnosticSignError .. ' ' end
	if bd.WarningCount > 0 then ret = ret .. '%#StatusLineHint#' .. bd.WarningCount .. ' ' .. '%#StatuslinediagnosticSignWarn#' .. M.diagnosticSymbols.DiagnosticSignWarn .. ' ' end
	if bd.InfoCount > 0 then    ret = ret .. '%#StatusLineHint#' .. bd.InfoCount .. ' ' .. '%#StatuslinediagnosticSignInfo#' .. M.diagnosticSymbols.DiagnosticSignInfo .. ' ' end
	if bd.HintCount > 0 then    ret = ret .. '%#StatusLineHint#' .. bd.HintCount .. ' ' .. '%#StatuslinediagnosticSignHint#' .. M.diagnosticSymbols.DiagnosticSignHint .. ' ' end
	return ret
end

M.ActiveLine = function()
	M.highlights = {}
	M.highlights.accent = '%#StatusLine#'
	M.highlights.normal = '%#StatusLineNC#'
	M.highlights.seperator = '%#StatusLineSep#'
	local stl = M.highlights.accent .. ' ' .. M.getGitBranch() .. ' '
	stl = stl .. M.highlights.seperator .. M.signs.LeftSep
	stl = stl .. M.highlights.normal .. '%=%f %h%w%m%r%=' .. M.getBufferDiagnostics()
	stl = stl .. M.highlights.seperator .. M.signs.RightSep
	stl = stl .. M.highlights.accent .. ' '
	stl = stl .. '%-6.(%l,%c%V%) %P '
	local comp_stl = ' ' .. stl
	return comp_stl
end

-- active status line gets refreshed all the time
M.statusline = function()
	vim.wo.statusline = '%!v:lua.require\'nonomain.utilities.statusline\'.ActiveLine()'
end
M.statuslineNC = function()
	local stl = M.getGitBranch() .. ' ' .. '%=%f %h%w%m%r%=%-6.(%l,%c%V%) %P '
	local comp_stl = ' ' .. stl
	vim.wo.statusline = comp_stl
end
M.enable = function()
	api.nvim_create_augroup('Statusline', { clear = true })
	api.nvim_create_autocmd('BufLeave', { command = 'lua require(\'nonomain/utilities/statusline\').statuslineNC()' , group = 'Statusline'})
	api.nvim_create_autocmd('WinLeave', { command = 'lua require(\'nonomain/utilities/statusline\').statuslineNC()' , group = 'Statusline'})
	api.nvim_create_autocmd('BufEnter', { command = 'lua require(\'nonomain/utilities/statusline\').statusline()' , group = 'Statusline'})
	api.nvim_create_autocmd('WinEnter', { command = 'lua require(\'nonomain/utilities/statusline\').statusline()' , group = 'Statusline'})
end
M.disable = function()
	api.nvim_del_augroup_by_name('Statusline')
	local tabs = fn.gettabinfo()
	for _, tab in pairs(tabs) do
		for _, window in pairs(tab.windows) do
			fn.setwinvar(window, '&statusline', '')
		end
	end
end

return {
	ActiveLine = M.ActiveLine,
	statusline = M.statusline,
	statuslineNC = M.statuslineNC,
	enable = M.enable,
	disable = M.disable,
}
