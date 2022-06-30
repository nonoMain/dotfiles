local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local api = vim.api
local M = {};

M.toggle = function()
	if vim.bo.buftype == 'terminal' then -- quit while inside terminal
		api.nvim_command('Bwipeout!')
	else -- open the explorer
		api.nvim_command('terminal')
		api.nvim_command('setlocal bufhidden=wipe')
		api.nvim_command('setlocal nonumber')
		api.nvim_command('setlocal norelativenumber')
		api.nvim_command('setlocal nocursorcolumn')
		api.nvim_command('setlocal colorcolumn=""')
	end
end

keymap('n', '<leader>t', '<cmd>lua require(\'nonomain/utilities/terminal\').toggle()<CR>', opts)

return {
	toggle = M.toggle,
}
