local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- use jk to exit faster
keymap('i', 'jk', '<ESC>', opts)
keymap('t', 'jk', '<C-\\><C-N>', term_opts)

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Better block movment
keymap('n', '<A-j>', '<Esc>:m .+1<CR>', opts)
keymap('n', '<A-k>', '<Esc>:m .-2<CR>', opts)
-- Better visual text handling
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
keymap('v', '<A-k>', ':m \'<-2<CR>gv', opts)
keymap('v', '<A-j>', ':m \'>+1<CR>gv', opts)
keymap('v', 'P', '\"_dP', opts) -- paste without overwriting the register

-- Allow increament and decreament with Alt-a/Alt-x
-- Ctrl-a/Ctrl-x are sometimes used for actions in the shell itself
-- so another way is always handy
keymap('n', '<A-a>', '<C-a>', opts)
keymap('n', '<A-x>', '<C-x>', opts)
keymap('v', '<A-a>', '<C-a>', opts)
keymap('v', '<A-x>', '<C-x>', opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)
