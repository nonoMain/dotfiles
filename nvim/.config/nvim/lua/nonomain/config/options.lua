local opt = vim.opt
local api = vim.api

-- Undo settings
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000

-- Indentation settings
opt.smartindent = true
opt.autoindent  = true
opt.expandtab = false
opt.tabstop = 4
opt.shiftwidth = 4

-- UI
api.nvim_command('colorscheme cplex')
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.errorbells = false
opt.showmatch = true
opt.showmode = true
opt.ignorecase = true
opt.smartcase = true
opt.linebreak = true
opt.hlsearch = true
opt.showmode = true
opt.wrap = false
opt.guicursor=''
opt.completeopt = 'menuone'
opt.backspace = 'indent,eol,start'
opt.pumheight = 10
opt.pumblend = 3
opt.conceallevel = 0
opt.showtabline = 2
opt.timeoutlen = 200
opt.foldmethod = 'indent'
opt.colorcolumn = '100'
opt.list = true
opt.listchars = 'tab: ,eol:¬,trail:~,lead:~,extends:>,precedes:<,nbsp:⨷'
opt.fillchars = 'stlnc: ,stl: ,vert:│,fold:-,diff:-,eob:~'
-- only losers use the mouse but if you want to put:
-- opt.mouse = 'a'

-- Backend
opt.swapfile = true
opt.fileencoding = 'utf-8'
opt.encoding = 'utf-8'
if vim.fn.has('win32') then
	opt.shada = "!,'250,<50,s10,h,rA:,rB:"
else
	opt.shada = "!,'250,<50,s10,h"
end

-- Usage
opt.hidden = true
opt.history = 100
opt.lazyredraw = true
opt.synmaxcol = 500
opt.updatetime = 300

-- Augroups
-- Active cursor have lines
api.nvim_create_augroup('CursorlinesOnActiveOnly', { clear = false })
api.nvim_create_autocmd('WinLeave', { command = 'set nocursorline nocursorcolumn' , group = 'CursorlinesOnActiveOnly'})
api.nvim_create_autocmd('WinEnter', { command = 'set cursorline cursorcolumn' , group = 'CursorlinesOnActiveOnly'})
api.nvim_create_autocmd('VimEnter', { command = 'set cursorline cursorcolumn' , group = 'CursorlinesOnActiveOnly'})
-- Buffer starts with the current minimum limit foldlevel value
api.nvim_create_augroup('SetFoldLevel', { clear = true })
api.nvim_create_autocmd('BufWinEnter', { command = 'let &foldlevel = max(map(range(1, line(\'$\')), \'foldlevel(v:val)\'))' , group = 'SetFoldLevel'})

opt.shortmess:append 'sI' -- Disable nvim intro
