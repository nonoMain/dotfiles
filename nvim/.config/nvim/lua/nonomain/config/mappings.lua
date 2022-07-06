local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- use jk to exit faster
keymap('i', "jk", "<ESC>", opts)
keymap('t', "jk", "<C-\\><C-N>", term_opts)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Navigate buffers
keymap('n', "<S-l>", "<cmd>bnext<CR>", opts)
keymap('n', "<S-h>", "<cmd>bprevious<CR>", opts)

-- Resize with arrows
keymap('n', "<C-Up>", "<cmd>resize -2<CR>", opts)
keymap('n', "<C-Down>", "<cmd>resize +2<CR>", opts)
keymap('n', "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap('n', "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Better block movment
keymap('n', "<A-j>", "<cmd>m .+1<CR>", opts)
keymap('n', "<A-k>", "<cmd>m .-2<CR>", opts)
-- Better visual text handling
keymap('v', '<', "<gv", opts)
keymap('v', '>', ">gv", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv", opts)
keymap('v', 'P', "\"_dP", opts) -- paste without overwriting the register

-- Allow increament and decreament with Alt-a/Alt-x
-- Ctrl-a/Ctrl-x are sometimes used for actions in the shell itself
-- so another way is always handy
keymap('n', "<A-a>", "<C-a>", opts)
keymap('n', "<A-x>", "<C-x>", opts)
keymap('v', "<A-a>", "<C-a>", opts)
keymap('v', "<A-x>", "<C-x>", opts)

-- Resize with arrows
keymap('n', "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap('n', "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap('n', "<C-Left>", "<cmd>vertical resize +2<CR>", opts)
keymap('n', "<C-Right>", "<cmd>vertical resize -2<CR>", opts)

-- Open new buffer in a new tab using leader+n
keymap('n', "<leader>n", "<cmd>tabnew<CR>", opts)
-- Close buffer using leader+q
keymap('n', "<leader>q", "<cmd>q<CR>", opts)

-- call FZF using leader+f
keymap('n', "<leader>f", "<cmd>FZF<CR>", opts)

-- reload the entire config
keymap('n', "<leader><leader>r", function()
	for p in pairs(package.loaded) do
		if p:match('nonomain') then
		package.loaded[p] = nil
		require(p)
		end
	end
	print('reloaded nonomain modules')
end)
