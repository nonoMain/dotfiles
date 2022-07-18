local M = {}

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local api = vim.api
local fn = vim.fn

---Common commentstring shared b/w mutliple languages
M.common = {
	cxx_l = "//%s",
	cxx_b = "/*%s*/",
	hashtag = "#%s",
	double_hashtag = "##%s",
	dash = "--%s",
	dash_bracket = "--[[%s]]",
	haskell_b = "{-%s-}",
	fsharp_b = "(*%s*)",
	html = "<!--%s-->",
	latex = "%%s",
	lisp_l = ";;%s",
	lisp_b = "#|%s|#",
}

---Lang table that contains commentstring (linewise/blockwise) for mutliple filetypes
---Structure = { filetype = { linewise, blockwise } }
---@type table<string,string[]>
M.specific = {
	arduino = { M.common.cxx_l, M.common.cxx_b },
	bash = { M.common.hashtag },
	bib = { M.common.latex },
	c = { M.common.cxx_l, M.common.cxx_b },
	cabal = { M.common.dash },
	cmake = { M.common.hashtag, "#[[%s]]" },
	conf = { M.common.hashtag },
	conkyrc = { M.common.dash, M.common.dash_bracket },
	cpp = { M.common.cxx_l, M.common.cxx_b },
	cs = { M.common.cxx_l, M.common.cxx_b },
	css = { M.common.cxx_b, M.common.cxx_b },
	cuda = { M.common.cxx_l, M.common.cxx_b },
	dhall = { M.common.dash, M.common.haskell_b },
	dot = { M.common.cxx_l, M.common.cxx_b },
	eelixir = { M.common.html, M.common.html },
	elixir = { M.common.hashtag },
	elm = { M.common.dash, M.common.haskell_b },
	fennel = { M.common.lisp_l },
	fish = { M.common.hashtag },
	fsharp = { M.common.cxx_l, M.common.fsharp_b },
	gdb = { M.common.hashtag },
	gdscript = { M.common.hashtag },
	gleam = { M.common.cxx_l },
	go = { M.common.cxx_l, M.common.cxx_b },
	graphql = { M.common.hashtag },
	groovy = { M.common.cxx_l, M.common.cxx_b },
	haskell = { M.common.dash, M.common.haskell_b },
	heex = { M.common.html, M.common.html },
	html = { M.common.html, M.common.html },
	htmldjango = { M.common.html, M.common.html },
	idris = { M.common.dash, M.common.haskell_b },
	ini = { M.common.hashtag },
	java = { M.common.cxx_l, M.common.cxx_b },
	javascript = { M.common.cxx_l, M.common.cxx_b },
	javascriptreact = { M.common.cxx_l, M.common.cxx_b },
	jsonc = { M.common.cxx_l },
	julia = { M.common.hashtag, "#=%s=#" },
	kotlin = { M.common.cxx_l, M.common.cxx_b },
	lidris = { M.common.dash, M.common.haskell_b },
	lisp = { M.common.lisp_l, M.common.lisp_b },
	lua = { M.common.dash, M.common.dash_bracket },
	markdown = { M.common.html, M.common.html },
	make = { M.common.hashtag },
	mbsyncrc = { M.common.double_hashtag },
	meson = { M.common.hashtag },
	nix = { M.common.hashtag, M.common.cxx_b },
	ocaml = { M.common.fsharp_b, M.common.fsharp_b },
	plantuml = { "'%s", "/'%s'/" },
	purescript = { M.common.dash, M.common.haskell_b },
	python = { M.common.hashtag },
	php = { M.common.cxx_l, M.common.cxx_b },
	r = { M.common.hashtag },
	readline = { M.common.hashtag },
	ruby = { M.common.hashtag },
	rust = { M.common.cxx_l, M.common.cxx_b },
	scala = { M.common.cxx_l, M.common.cxx_b },
	scheme = { M.common.lisp_l, M.common.lisp_b },
	sh = { M.common.hashtag },
	solidity = { M.common.cxx_l, M.common.cxx_b },
	sql = { M.common.dash, M.common.cxx_b },
	stata = { M.common.cxx_l, M.common.cxx_b },
	svelte = { M.common.html, M.common.html },
	swift = { M.common.cxx_l, M.common.cxx_b },
	sxhkdrc = { M.common.hashtag },
	teal = { M.common.dash, M.common.dash_bracket },
	terraform = { M.common.hashtag, M.common.cxx_b },
	tex = { M.common.latex },
	template = { M.common.double_hashtag },
	tmux = { M.common.hashtag },
	toml = { M.common.hashtag },
	typescript = { M.common.cxx_l, M.common.cxx_b },
	typescriptreact = { M.common.cxx_l, M.common.cxx_b },
	vim = { '"%s' },
	vue = { M.common.html, M.common.html },
	xml = { M.common.html, M.common.html },
	xdefaults = { "!%s" },
	yaml = { M.common.hashtag },
	zig = { M.common.cxx_l },
	asm = { ";%s" },
}

M.getCommentDictByFt = function(ft)
	return M.specific[ft]
end

M.getCurrentCommentDict = function()
	return M.getCommentDictByFt(fn.getbufvar(fn.bufnr(), "&filetype"))
end

keymap({ 'n' }, "<leader>c", function()
	local dict = M.getCurrentCommentDict()
	if dict ~= nil then
		api.nvim_feedkeys("O".. dict[1] .. "\x03F%c2l", 'm' , true)
	else
		print("Comment syntax wasn't detected")
	end
end, opts)

keymap({ 'n' }, "<leader><leader>c", function()
	local dict = M.getCurrentCommentDict()
	if dict ~= nil then
		if #dict > 1 then
			api.nvim_feedkeys("O".. dict[2] .. "\x03F%c2l", 'm' , true)
		else
			api.nvim_feedkeys("O".. dict[1] .. "\x03F%c2l", 'm' , true)
		end
	else
		print("Comment syntax wasn't detected")
	end
end, opts)
