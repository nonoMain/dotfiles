local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path, }
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- config packer
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

return require("packer").startup(function(use)
		use "wbthomason/packer.nvim"            -- packer.nvim (a plugin manager needs to plug itself..)

		use {
			"neovim/nvim-lspconfig",            -- nvim-lsp support
			"williamboman/nvim-lsp-installer",  -- install lsp servers (cross platform)
		}

		use {
			"nvim-treesitter/nvim-treesitter",  -- treesitter (1)
			run = ":TSUpdate",
			config = function() require "nonomain.plugins.nvim-treesitter" end,
		}

		use {
			"nvim-treesitter/playground",       -- treesitter (2)
			config = function() require "nonomain.plugins.nvim-treesitter-playground" end,
		}

		use {
			"L3MON4D3/LuaSnip",                 -- snippets
			config = function() require "nonomain.plugins.luasnip" end,
		}

		use {
			"lewis6991/gitsigns.nvim",          -- git diff signs
			config = function() require "nonomain.plugins.gitsigns" end,
		}

		use "tpope/vim-repeat"                  -- repeat plugin actions with the "." key

		use {                                   -- surround text faster
			"ur4ltz/surround.nvim",
			config = function() require"surround".setup {mappings_style = "sandwich"} end
		}

		use "norcalli/nvim-colorizer.lua"       -- coloring codes inside neovim

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end
)
