local ft = "lua"
local u = require("nonomain.plugins.luasnip.util")

require("luasnip.session.snippet_collection").clear_snippets(ft)

u.add_snippets(ft, {
	u.s({ trig = "req", name = "require module" },
		u.fmt("require('{}')", { u.i(1),})
	),
	u.s({ trig = "lreq", name = "localy require module (named by module's tail)" },
		u.fmt("local {} = require('{}')", { u.f(function(import_name)
			local parts = vim.split(import_name[1][1], ".", true)
			return parts[#parts]
		end, { 1 }), u.i(1)})
	),
	u.s({ trig = "fun", name = "function block" },
		u.fmt("function({})\n\t{}\nend", { u.i(1), u.i(0) })
	),
	u.s({ trig = "lfun", name = "local <name> function block" },
		u.fmt("local {} = function({})\n\t{}\nend", { u.i(1), u.i(2), u.i(0) })
	),
})
