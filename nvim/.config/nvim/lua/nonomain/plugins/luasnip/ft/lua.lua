local u = require("nonomain.plugins.luasnip.util")

u.add_snippets("lua",
{
	u.s({ trig = "req", name = "require" }, u.fmt("local {} require('{}')", { u.i(1), u.rep(1) }) ),
})
