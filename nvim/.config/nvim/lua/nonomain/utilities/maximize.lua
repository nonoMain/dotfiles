local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local api = vim.api
local M = {}

M.maximize_window = function()
	vim.t.prev_layout_cmd = api.nvim_call_function('winrestcmd', {})
	api.nvim_command('resize')
	api.nvim_command('vert resize')
	vim.t.post_layout_cmd = api.nvim_call_function('winrestcmd', {})
end

M.restore_windows = function()
	api.nvim_exec(vim.t.prev_layout_cmd, false)
end

M.toggle = function()
	if vim.t.prev_layout_cmd and vim.t.post_layout_cmd and ( vim.t.post_layout_cmd == api.nvim_call_function('winrestcmd', {}) ) then
			M.restore_windows()
	else
		M.maximize_window()
	end
end

keymap('n', '<leader>m', '<cmd>lua require(\'nonomain/utilities/maximize\').toggle()<CR>', opts)

return {
	toggle = M.toggle,
}
