local utils = require("nonomain.utilities.utils")
local ftdevicons = require("nonomain.utilities.ftdevicons")
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local api = vim.api
local fn = vim.fn

local M = {}

M.buffers_shown = {}
M.lines_shown = {}

M.openBuffer = function()
	local file = M.buffers_shown[fn.line('.') - 1]
	if file ~= nil then vim.cmd(string.format("edit %s", file)) end
end

M.openBrowser = function()
	-- reset files shown
	M.buffers_shown = {}
	M.lines_shown = {}
	vim.cmd [[ enew ]]

	for _, buffer in pairs(utils.get_listed_buffer_paths()) do
		local symbol = ""
		local line = ""
		if vim.g.devicons then
			symbol = ftdevicons.getPathSymbol(buffer)
		end
		line = "⦁ " .. symbol .. ' ' .. buffer
		table.insert(M.buffers_shown, buffer)
		table.insert(M.lines_shown, line)
	end
	api.nvim_put(M.lines_shown, "l", true, false)

	keymap('n', '<CR>', M.openBuffer, { noremap = true, silent = true, buffer = vim.fn.bufnr() })

	-- local settings
	vim.cmd [[
		setlocal nomodifiable
		setlocal noswapfile
		setlocal buftype=nofile
		setlocal bufhidden=wipe
		setlocal filetype=buffersBrowser
		setlocal conceallevel=2
		setlocal nocursorcolumn
		setlocal colorcolumn=""
		setlocal nolist
		setlocal nospell
		setlocal nowrap
	]]
end

M.toggle = function()
	if vim.bo.filetype == 'buffersBrowser' then -- quit while browsing
		utils.bkill(0)
	else -- open the browser
		M.openBrowser()
	end
end

if vim.g.devicons then
	api.nvim_create_augroup("BufferBrowser", { clear = true })
	api.nvim_create_autocmd({ "FileType" }, { pattern = "buffersBrowser", callback = function()
		vim.schedule(function()
			for color, icons in pairs(ftdevicons.iconsColorDicts) do
				vim.cmd(string.format("syntax match ftdevicons%s /\\v%s/ containedin=ALL", color, table.concat(icons,'|')), false)
			end
		end)
	end, group = "BufferBrowser"})
end

keymap('n', '<leader>b', M.toggle, opts)

return { toggle = M.toggle }
