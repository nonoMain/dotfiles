local luasnip = require("luasnip")
local au = require("au")
vim.luasnip = {}
local M = {}

if vim.g.devicons then
	M.snippet_sign = ''
else
	M.snippet_sign = 'S'
end

local function snippet2completion(snippet)
	return {
		word = snippet.trigger,
		menu = snippet.name,
		info = vim.trim(table.concat(vim.tbl_flatten({snippet.dscr or "", "", snippet:get_docstring()}), "\n")),
		kind = M.snippet_sign,
		dup = true,
		user_data = "luasnip"
	}
end

local function snippetfilter(line_to_cursor, base)
	return function(s)
		return not s.hidden and vim.startswith(s.trigger, base) and s.show_condition(line_to_cursor)
	end
end

function vim.luasnip.completefunc(findstart, base)
	local line, col = vim.api.nvim_get_current_line(), vim.api.nvim_win_get_cursor(0)[2]
	local line_to_cursor = line:sub(1, col)

	if findstart == 1 then
		return vim.fn.match(line_to_cursor, '\\k*$')
	end

	local snippets = vim.list_extend(vim.list_slice(luasnip.get_snippets("all")), luasnip.get_snippets(vim.bo.filetype))
	snippets = vim.tbl_filter(snippetfilter(line_to_cursor, base), snippets)
	snippets = vim.tbl_map(snippet2completion, snippets)
	table.sort(snippets, function(s1, s2) return s1.word < s2.word end)
	return snippets
end

local luasnip_completion_expand = au("luasnip_completion_expand")
function luasnip_completion_expand.CompleteDone()
	if vim.v.completed_item.user_data == "luasnip" and luasnip.expandable() then
		luasnip.expand()
	end
end

M.enable = function()
	vim.opt.completefunc = "v:lua.vim.luasnip.completefunc"
end

M.disable = function()
	vim.opt.completefunc = ""
end

return {
	enable = M.enable,
	disable = M.disable,
}
