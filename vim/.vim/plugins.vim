
" To install vim-plug (the used plugin manager):

" ## for unix / linux
"sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

" ## for windows (powershell)
"iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
"    ni \"$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim\" -Force

call plug#begin($MYVIMRCFOLDER .. '/autoload/plugged')
" Surround text in a smart manner..
	Plug 'tpope/vim-surround'

" Repeats whole maps with '.' (for plugins)
	Plug 'tpope/vim-repeat'

" Fast snippets
	Plug 'SirVer/ultisnips'
call plug#end()
