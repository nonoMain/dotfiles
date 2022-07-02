local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local status_ok, _ = pcall(require, 'nvim-treesitter-playground')
if not status_ok then
	return
end
keymap('n', '<f10>', '<cmd>TSHighlightCapturesUnderCursor<CR>', opts)
