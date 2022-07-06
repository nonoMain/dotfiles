local utils = require("nonomain.utilities.utils")
-- Netrw settings
vim.g.netrw_fastbrowse = 0
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local api = vim.api
local M = {};

M.toggle = function()
	if vim.bo.filetype == "netrw" then -- quit while browsing
		utils.bkill(0)
	else -- open the explorer
		api.nvim_command("Explore")
	end
end

M.augroup = api.nvim_create_augroup("NetrwConfig", { clear = true })

-- netrw needs autocmd because each time you move to another directory its a new buffer
api.nvim_create_autocmd( "FileType", {
	pattern = "netrw",
	callback = function()
		vim.cmd [[
			setlocal bufhidden=wipe
			setlocal nocursorcolumn
			setlocal colorcolumn=""
		]]
	end,
	group = "NetrwConfig",
})

keymap('n', "<leader>e", M.toggle, opts)

return { toggle = M.toggle, }
