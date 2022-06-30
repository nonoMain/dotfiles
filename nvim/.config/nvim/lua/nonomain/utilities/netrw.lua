-- Netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local api = vim.api
local M = {};

M.toggle = function()
	if vim.bo.filetype == 'netrw' then -- quit while browsing
		api.nvim_command('Bwipeout')
	else -- open the explorer
		api.nvim_command('Explore')
		api.nvim_command('setlocal bufhidden=wipe nocursorcolumn colorcolumn=""')
	end
end

keymap('n', '<leader>e', '<cmd>lua require(\'nonomain/utilities/netrw\').toggle()<CR>', opts)

return M;
