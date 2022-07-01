local api = vim.api
local M = {}

M.branch = function()
	local maybe = false
	local branch = ''
	maybe, branch = pcall(api.nvim_call_function, 'g:FugitiveHead', {})
	if not maybe or #branch == 0 or branch == nil then
		maybe, branch = pcall(io.popen, "git rev-parse --abbrev-ref HEAD 2> /dev/null")
		if not maybe or #branch == 0 then
			return ''
		end
	end
	return branch
end


return M
