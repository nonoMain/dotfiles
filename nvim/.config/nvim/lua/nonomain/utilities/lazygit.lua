local utils = require("nonomain.utilities.utils")
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local api = vim.api
local M = {};
M.command = "lazygit"

M.toggle = function()
	if vim.bo.buftype == "terminal" then -- quit while inside git client
		utils.bkill(0)
	else -- open the git client
		api.nvim_command("terminal " .. M.command)
		vim.bo.bufhidden = "wipe"
		api.nvim_command("startinsert")
	end
end

keymap({'n', 't'}, "<leader>g", M.toggle, opts)

return {
	toggle = M.toggle,
	command = M.command,
}

