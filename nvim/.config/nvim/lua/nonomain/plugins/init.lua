-- Bootstrap lazy
local lazypath = vim.fn.stdpath "data"  .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
	"--depth",
	"1",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

return lazy.setup({
	"neovim/nvim-lspconfig",            -- nvim-lsp support

	{
		"williamboman/mason.nvim",  -- install lsp servers (cross platform)
		config = function() require "mason".setup() end,
	},
	"williamboman/mason-lspconfig.nvim",  -- install lsp servers (cross platform)

	{
		"nvim-treesitter/nvim-treesitter",  -- treesitter (1)
		run = ":TSUpdate",
		config = function() require "nonomain.plugins.nvim-treesitter" end,
	},

	{
		"nvim-treesitter/playground",       -- treesitter (2)
		config = function() require "nonomain.plugins.nvim-treesitter-playground" end,
	},

	"SirVer/ultisnips",

	{
		"lewis6991/gitsigns.nvim",          -- git diff signs
		config = function() require "nonomain.plugins.gitsigns" end,
	},

	"tpope/vim-repeat",                  -- repeat plugin actions with the "." key

	{                                   -- surround text faster
		"ur4ltz/surround.nvim",
		config = function() require("surround").setup {mappings_style = "sandwich"} end
	},

	"norcalli/nvim-colorizer.lua",       -- coloring codes inside neovim
})
