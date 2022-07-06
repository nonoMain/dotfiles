local utils = require("nonomain.utilities.utils")
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local api = vim.api
local M = {};

M.toggle = function()
	if vim.bo.buftype == "terminal" then -- quit while inside terminal
		utils.bkill(0)
	else -- open the terminal
		api.nvim_command("terminal")
		vim.cmd [[
			setlocal bufhidden=wipe
			setlocal nonumber
			setlocal norelativenumber
			setlocal colorcolumn=""
		]]
		api.nvim_command("startinsert")
	end
end

keymap({'n', 't'}, "<leader>t", M.toggle, opts)

return { toggle = M.toggle }
