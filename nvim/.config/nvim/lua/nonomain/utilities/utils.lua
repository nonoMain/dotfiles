local fn = vim.fn
local api = vim.api
local M = {}

M.capture_command = function(cmd, raw)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read("*a"))
	f:close()
	if raw then return s end
	s = string.gsub(s, "^%s+", '')
	s = string.gsub(s, "%s+$", '')
	s = string.gsub(s, "[\n\r]+", ' ')
	return s
end

M.is_dir = function(path)
	local f = io.open(path, 'r')
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
	return not M.is_dir(file) and f and io.close(f)
end

M.get_git_branch_by_path = function(path)
	if not M.is_dir(path) then path = vim.fn.fnamemodify(path, ":p:h") end
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

M.get_listed_buffer_paths = function()
	local buffers = {}

	for buffer = 1, fn.bufnr('$') do
		if api.nvim_buf_is_valid(buffer) and fn.buflisted(buffer) and M.is_readable_file(api.nvim_buf_get_name(buffer)) then
			table.insert(buffers, api.nvim_buf_get_name(buffer))
		end
	end

	return buffers
end

-- Common kill function for bdelete and bwipeout
-- credits: based on bbye
M.bclose = function(command, bufnr, force)

	if bufnr < 0 then
		return api.nvim_err_writeln( string.format("E516: No buffers were deleted. No match for %d", bufnr))
	end

	if bufnr == 0 or bufnr == nil then
		bufnr = api.nvim_get_current_buf()
	end

	command = command or "bd"

	-- If buffer is modified and force isn't true, print error and abort
	if not force and vim.bo[bufnr].modified then
		return api.nvim_err_writeln( string.format("No write since last change for buffer %d (set force to true to override)", bufnr))
	end

	-- Get list of windows IDs with the buffer to close
	local windows = vim.tbl_filter(function(win)
		return api.nvim_win_get_buf(win) == bufnr
	end, api.nvim_list_wins())

	if #windows == 0 then
		return
	end

	if force then
		command = command .. "!"
	end

	-- Get list of active buffers
	local buffers = vim.tbl_filter(function(buf)
		return api.nvim_buf_is_valid(buf)
	end, api.nvim_list_bufs())

	-- If there is only one buffer (which has to be the current one), vim will
	-- create a new buffer on :bd.
	-- For more than one buffer, pick the previous buffer (wrapping around if necessary)
	if #buffers > 1 then
		for i, v in ipairs(buffers) do
			if v == bufnr then
				local prev_buf_idx = i == 1 and (#buffers - 1) or (i - 1)
				local prev_buffer = buffers[prev_buf_idx]
				for _, win in ipairs(windows) do
					api.nvim_win_set_buf(win, prev_buffer)
				end
			end
		end
	end

	-- Check if buffer still exists, to ensure the target buffer wasn't killed
	-- due to options like bufhidden=wipe.
	if api.nvim_buf_is_valid(bufnr) then
		vim.cmd(string.format("%s %d", command, bufnr))
	end
end

M.bkill = function(bufnr)
	M.bclose("bwipeout", bufnr, true)
end

return M
