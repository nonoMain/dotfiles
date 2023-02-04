vim.env.MYVIMRCFOLDER = vim.fn.fnamemodify(vim.env.MYVIMRC, ":p:h")
vim.g.devicons = true                             -- devicons and such

require "nonomain.config"                         -- CONFIG --
require "nonomain.plugins"                        -- PLUGINS --
require "nonomain.utilities"                      -- UTILS --
require "nonomain.lsp".setup({                    -- Language Server Protocol --
	"sumneko_lua",                                -- • Lua
	"bashls",                                     -- • Bash
	"vimls",                                      -- • Vimscript
	"pyright",                                    -- • Python
	"clangd",                                     -- • C/Cpp/Obj-c/Obj-cpp
	"gopls",                                      -- • Golang
	"jdtls",                                      -- • Java
	"csharp_ls",                                  -- • C#
	"rust_analyzer"                               -- • Rust
})

require "nonomain.utilities.utils".disable({      -- disable builtin plugins
	"2html_plugin",
	"spellfile_plugin",
	"fzf",
	"gzip",
	"getscriptPlugin",
	"vimballPlugin",
	"tarPlugin",
	"zipPlugin",
	"tutor_mode_plugin",
})
