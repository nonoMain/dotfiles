vim.env.MYVIMRCFOLDER = vim.fn.fnamemodify(vim.env.MYVIMRC, ":p:h")

vim.g.devicons = true                             -- devicons and such

require "nonomain.config"                         -- CONFIG --
require "nonomain.utilities"                      -- UTILS --
require "nonomain.plugins"                        -- PLUGINS --
require "nonomain.lsp".setup({                    -- LANGUAGE SERVER PROTOCOL --
	"sumneko_lua",                                -- [Lua]
	"bashls",                                     -- [Bash]
	"vimls",                                      -- [Vimscript]
	"pyright",                                    -- [Python]
	"clangd",                                     -- [C/Cpp/Obj-c/Obj-cpp]
	"gopls",                                      -- [Golang]
	"jdtls",                                      -- [Java]
	"csharp_ls",                                  -- [C#]
})
