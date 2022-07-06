
local ls = require("luasnip")
local M = {}

M.s = ls.s
M.f = ls.function_node
M.t = ls.text_node
M.i = ls.insert_node
M.fmt = require("luasnip.extras.fmt").fmt
M.rep = require("luasnip.extras").rep

M.add_snippets = ls.add_snippets

return M
