local M = {}

M.capture_command = function(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

M.is_dir = function(path)
    local f = io.open(path, "r")
	if f ~= nil then
		local _, _, code = f:read(1)
		f:close()
		-- 21 -> 'is a directory'
		return code == 21
	end
	return false
end

M.is_readable_file = function(file)
	local f = io.open(file)
	return f and io.close(f)
end

M.get_git_branch_by_path = function(path)
	if not M.is_dir(path) then path = vim.fn.fnamemodify(path, ':p:h') end
	if not M.is_dir(path) then return nil end
	-- path is a directory
	local maybe = false
	local branch = ''
	local command = "git -C " .. path .. " rev-parse --abbrev-ref HEAD 2> /dev/null"
	maybe, branch = pcall(M.capture_command, command)
	if not maybe or branch == '' then
		return ''
	end
	return branch
end

M.get_git_branch = function()
	return M.get_git_branch_by_path(vim.fn.bufname())
end

return M
