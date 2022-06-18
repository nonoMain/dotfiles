local g = vim.g
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
opt.relativenumber = true
opt.errorbells = false
opt.showmatch = true
opt.showmode = true
opt.ignorecase = true
opt.smartcase = true
opt.linebreak = true
opt.hlsearch = true
opt.showmode = true
opt.number = true
opt.wrap = false
opt.guicursor=''
opt.mouse = 'a'
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
opt.listchars = 'tab: ,eol:¬,trail:~,extends:>,precedes:<'
opt.fillchars = 'stlnc: ,stl: ,vert:│,fold:-,diff:-'

-- Backend
opt.swapfile = true
opt.fileencoding = 'utf-8'
opt.encoding = 'utf-8'

-- Usage
opt.hidden = true
opt.history = 100
opt.lazyredraw = true
opt.synmaxcol = 500
opt.updatetime = 300

-- Cursor augroup
api.nvim_create_augroup('CursorlinesOnActiveOnly', { clear = false })
api.nvim_create_autocmd('WinLeave', { command = 'set nocursorline nocursorcolumn' , group = 'CursorlinesOnActiveOnly'})
api.nvim_create_autocmd('WinEnter', { command = 'set cursorline cursorcolumn' , group = 'CursorlinesOnActiveOnly'})
api.nvim_create_autocmd('VimEnter', { command = 'set cursorline cursorcolumn' , group = 'CursorlinesOnActiveOnly'})

api.nvim_create_augroup('FoldTeller', { clear = true })
api.nvim_create_autocmd('BufWinEnter', { command = 'let &foldlevel = max(map(range(1, line(\'$\')), \'foldlevel(v:val)\'))' , group = 'FoldTeller'})

opt.shortmess:append 'sI' -- Disable nvim intro
