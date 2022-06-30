local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
	return
end
local status_ok, lsp_config = pcall(require, 'lspconfig')
if not status_ok then
	return
end

local M = {}

if vim.g.devicons then
M.signs = {
	{ name = 'DiagnosticSignError', text = '' },
	{ name = 'DiagnosticSignWarn', text = '' },
	{ name = 'DiagnosticSignInfo', text = '' },
	{ name = 'DiagnosticSignHint', text = '' },
}
else
M.signs = {
	{ name = 'DiagnosticSignError', text = 'E' },
	{ name = 'DiagnosticSignWarn', text = 'W' },
	{ name = 'DiagnosticSignHint', text = '?' },
	{ name = 'DiagnosticSignInfo', text = 'I' },
}
end

M.setup_installer = function(language_servers)
	local setup_table = {}
	setup_table.ensure_installed = language_servers
	if vim.g.devicons then
		setup_table.ui = {
				icons = {
				server_installed = '✔',
				server_pending = '➜',
				server_uninstalled = '✘'
				}
		}
	else
		setup_table.ui = {
				icons = {
				server_installed = 'V',
				server_pending = 'W',
				server_uninstalled = 'X'
				}
		}
	end
	lsp_installer.setup(setup_table)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
	local opts = { noremap=true, silent=true }
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-p>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-n>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

M.setup_configs = function(language_servers)
	local border = {
		{ '┌', 'FloatBorder' },
		{ '─', 'FloatBorder' },
		{ '┐', 'FloatBorder' },
		{ '│', 'FloatBorder' },
		{ '┘', 'FloatBorder' },
		{ '─', 'FloatBorder' },
		{ '└', 'FloatBorder' },
		{ '│', 'FloatBorder' },
	}

	for _, sign in ipairs(M.signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
	end

	vim.diagnostic.config({
		virtual_text = false,
		signs = {
			active = M.signs,
		},
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = 'minimal',
			border = border,
			source = 'always',
			header = '',
			prefix = '',
		},
	})

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = border,
	})
	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = border,
	})

	for _, server in pairs(language_servers) do
		local opts = {
			on_attach = M.on_attach,
		}
		local has_custom_opts, server_custom_opts = pcall(require, 'nonomain/lsp/settings/' .. server)
		if has_custom_opts then
			opts = vim.tbl_deep_extend('force', server_custom_opts, opts)
		end
		lsp_config[server].setup(opts)
	end
end

M.kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "塞",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

M.setLspSymbols = function()
	local kinds = vim.lsp.protocol.CompletionItemKind
	for i, kind in ipairs(kinds) do
		kinds[i] = M.kind_icons[kind] .. ' ' .. kind or kind
	end
end

-- the main function - call by require('nonomain/lsp').setup({language_servers_here})
M.setup = function(language_servers)
	if vim.g.devicons then
		M.setLspSymbols()
	end
	M.setup_installer(language_servers)
	M.setup_configs(language_servers)
end

return M
