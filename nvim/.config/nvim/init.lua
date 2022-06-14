vim.env.MYVIMRCFOLDER = vim.fn.fnamemodify(vim.env.MYVIMRC, ':p:h')
                                            -- CONFIG --
vim.g.devicons = true                       -- devicons and such
require 'nonomain/config/options'           -- settings
require 'nonomain/config/mappings'          -- keymaps
require 'nonomain/config/netrw'             -- nicer netrw
                                            -- UTILS --
require 'nonomain/utilities/colorscheme'    -- load color scheme
require 'nonomain/utilities/devicons'       -- use devicons
-- require 'nonomain/utilities/statusline'     -- my own statusline
-- require 'nonomain/utilities/tabline'        -- my own tabline
                                            -- PLUGINS --
require 'nonomain/plugins'                  -- install & load & config plugins (packer.nvim)
                                            -- LANGUAGE SERVER PROTOCOL --
require 'nonomain/lsp'.setup({              -- install & load lsp
	'sumneko_lua',
})
