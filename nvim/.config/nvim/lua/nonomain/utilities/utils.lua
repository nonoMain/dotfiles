local M = {}

M.is_dir = function(path)
    local f = io.open(path, "r")
	if f ~= nil then
		local _, _, code = f:read(1)
		f:close()
		return code == 21
	end
	return false
end

return M
