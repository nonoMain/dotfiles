local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local status_ok, setup = pcall(require, 'nvim-treesitter-playground')
if not status_ok then
	return
end
keymap('n', '<f10>', ':TSHighlightCapturesUnderCursor<CR>', opts)

