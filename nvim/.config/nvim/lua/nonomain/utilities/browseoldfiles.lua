local utils = require("nonomain.utilities.utils")
local ftdevicons = require("nonomain.utilities.ftdevicons")
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local api = vim.api
local fn = vim.fn

local M = {}

M.ignoreThese = {
	"vim/runtime/doc/.*.txt",
	"nvim/.*/doc/.*.txt",
}

M.files_shown = {}
M.lines_shown = {}

M.openFile = function()
	local file = M.files_shown[fn.line('.') - 1]
	if file ~= nil then vim.cmd(string.format("edit %s", file)) end
end

M.openBrowser = function()
	-- reset files shown
	M.files_shown = {}
	M.lines_shown = {}
	vim.cmd [[ enew ]]

	for _, file in pairs(vim.v.oldfiles) do
		local to_ignore = false
		local symbol = ""
		local line = ""
		if utils.is_readable_file(file) then
			if vim.g.devicons then
				symbol = ftdevicons.getPathSymbol(file)
			end
			for _, pattern in pairs(M.ignoreThese) do
				if file:match(pattern) then
					to_ignore = true
				end
			end
			if not to_ignore then
				line = " ⦁ " .. symbol .. ' ' .. file
				table.insert(M.files_shown, file)
				table.insert(M.lines_shown, line)
			end
		end
	end
	api.nvim_put(M.lines_shown, 'l', true, false)

	keymap('n', "<CR>", M.openFile, { noremap = true, silent = true, buffer = vim.fn.bufnr() })

	api.nvim_exec("file existing oldfiles", false)

	-- local settings
	vim.cmd [[
		setlocal nonumber
		setlocal norelativenumber
		setlocal nomodifiable
		setlocal noswapfile
		setlocal buftype=nofile
		setlocal bufhidden=wipe
		setlocal filetype=oldfilesBrowser
		setlocal conceallevel=2
		setlocal nocursorcolumn
		setlocal colorcolumn=""
		setlocal nolist
		setlocal nospell
		setlocal nowrap
	]]
end

M.toggle = function()
	if vim.bo.filetype == "oldfilesBrowser" then -- quit while browsing
		utils.bkill(0)
	else -- open the browser
		M.openBrowser()
	end
end

if vim.g.devicons then
	api.nvim_create_augroup("BrowseOldfiles", { clear = true })
	api.nvim_create_autocmd({ "FileType" }, { pattern = "oldfilesBrowser", callback = function()
		vim.schedule(function()
			for color, icons in pairs(ftdevicons.iconsColorDicts) do
				vim.cmd(string.format("syntax match %s /\\v%s/ containedin=ALL", color, table.concat(icons,'|')), false)
			end
		end)
	end, group = "BrowseOldfiles"})
end

keymap('n', "<leader>h", M.toggle, opts)

return { toggle = M.toggle }
