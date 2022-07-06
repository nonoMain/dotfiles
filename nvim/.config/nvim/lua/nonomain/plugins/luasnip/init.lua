local ls = require("luasnip")
-- support reloading by cleaning all the keymaps
ls.cleanup()
-- load all of my snippets
require("nonomain.plugins.luasnip.ft")
-- set completion
require("nonomain.plugins.luasnip.complete").enable()

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = false,
}

-- expand snippets
keymap({ "i" }, "<C-s>", function()
	if ls.expandable() then ls.expand() end
end, opts)
-- jump forward
keymap({ "i" }, "<C-k>", function()
	if ls.jumpable(1) then ls.jump(1) end
end, opts)
-- jump backward
keymap({ "i" }, "<C-j>", function()
	if ls.jumpable(-1) then ls.jump(-1) end
end, opts)
-- next choice
keymap({ "i" }, "<C-l>", function()
	if ls.choice_active() then ls.change_choice(1) end
end, opts)
-- prev choice
keymap({ "i" }, "<C-h>", function()
	if ls.choice_active() then ls.change_choice(-1) end
end, opts)
-- pick current choice
keymap({ "i" }, "<C-u>", function()
	if ls.choice_active() then require("luasnip.extras.select_choice") end
end, opts)
