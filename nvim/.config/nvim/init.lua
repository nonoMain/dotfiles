vim.env.MYVIMRCFOLDER = vim.fn.fnamemodify(vim.env.MYVIMRC, ':p:h')
                                                  -- CONFIG --
vim.g.devicons = true                             -- devicons and such
require 'nonomain/config/options'                 -- settings
require 'nonomain/config/mappings'                -- keymaps
                                                  -- UTILS --
require 'nonomain/utilities/maximize'             -- un/maximize windows (<leader>m)
require 'nonomain/utilities/netrw'                -- nicer togglable netrw (<leader>e)
require 'nonomain/utilities/terminal'             -- nicer togglable terminal (<leader>t)
require 'nonomain/utilities/ftdevicons'
require 'nonomain/utilities/statusline'.enable()  -- my own statusline
require 'nonomain/utilities/tabline'.enable()     -- my own tabline
                                                  -- PLUGINS --
require 'nonomain/plugins'                        -- install & load & config plugins (packer.nvim)
                                                  -- LANGUAGE SERVER PROTOCOL --
require 'nonomain/lsp'.setup({                    -- install & load lsp
	'sumneko_lua',                                -- [Lua]
	'bashls',                                     -- [Bash]
	'vimls',                                      -- [Vimscript]
	'pyright',                                    -- [Python]
	'clangd',                                     -- [C/Cpp/Obj-c/Obj-cpp]
	'gopls',                                      -- [Golang]
	'jdtls',                                      -- [Java]
	'csharp_ls',                                  -- [C#]
})
