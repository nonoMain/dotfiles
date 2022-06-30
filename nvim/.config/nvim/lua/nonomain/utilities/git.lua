local M = {}

M.branch = function()
	local branch = io.popen("git rev-parse --abbrev-ref HEAD 2> /dev/null")
	if branch then
		local name = branch:read("*l")
		branch:close()
		if name then
			return name
		else
			return ""
		end
	end
end

return M
