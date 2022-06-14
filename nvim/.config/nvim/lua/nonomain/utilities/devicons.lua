local M = {}

M.enabled = false

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

M.extentionSymbols = {}
M.extentionSymbols['ai']                      = ''
M.extentionSymbols['awk']                     = ''
M.extentionSymbols['bash']                    = ''
M.extentionSymbols['bat']                     = ''
M.extentionSymbols['bmp']                     = ''
M.extentionSymbols['c']                       = ''
M.extentionSymbols['c++']                     = ''
M.extentionSymbols['cp']                      = ''
M.extentionSymbols['cpp']                     = ''
M.extentionSymbols['cc']                      = ''
M.extentionSymbols['clj']                     = ''
M.extentionSymbols['cljc']                    = ''
M.extentionSymbols['cljs']                    = ''
M.extentionSymbols['coffee']                  = ''
M.extentionSymbols['conf']                    = ''
M.extentionSymbols['cs']                      = ''
M.extentionSymbols['csh']                     = ''
M.extentionSymbols['css']                     = ''
M.extentionSymbols['cxx']                     = ''
M.extentionSymbols['d']                       = ''
M.extentionSymbols['dart']                    = ''
M.extentionSymbols['db']                      = ''
M.extentionSymbols['diff']                    = ''
M.extentionSymbols['dump']                    = ''
M.extentionSymbols['edn']                     = ''
M.extentionSymbols['eex']                     = ''
M.extentionSymbols['ejs']                     = ''
M.extentionSymbols['elm']                     = ''
M.extentionSymbols['erl']                     = ''
M.extentionSymbols['ex']                      = ''
M.extentionSymbols['exs']                     = ''
M.extentionSymbols['f#']                      = ''
M.extentionSymbols['fish']                    = ''
M.extentionSymbols['fs']                      = ''
M.extentionSymbols['fsi']                     = ''
M.extentionSymbols['fsscript']                = ''
M.extentionSymbols['fsx']                     = ''
M.extentionSymbols['gemspec']                 = ''
M.extentionSymbols['gif']                     = ''
M.extentionSymbols['go']                      = ''
M.extentionSymbols['h']                       = ''
M.extentionSymbols['haml']                    = ''
M.extentionSymbols['hbs']                     = ''
M.extentionSymbols['hh']                      = ''
M.extentionSymbols['hpp']                     = ''
M.extentionSymbols['hrl']                     = ''
M.extentionSymbols['hs']                      = ''
M.extentionSymbols['htm']                     = ''
M.extentionSymbols['html']                    = ''
M.extentionSymbols['hxx']                     = ''
M.extentionSymbols['ico']                     = ''
M.extentionSymbols['ini']                     = ''
M.extentionSymbols['java']                    = ''
M.extentionSymbols['jl']                      = ''
M.extentionSymbols['jpeg']                    = ''
M.extentionSymbols['jpg']                     = ''
M.extentionSymbols['js']                      = ''
M.extentionSymbols['json']                    = ''
M.extentionSymbols['jsx']                     = ''
M.extentionSymbols['ksh']                     = ''
M.extentionSymbols['leex']                    = ''
M.extentionSymbols['less']                    = ''
M.extentionSymbols['lhs']                     = ''
M.extentionSymbols['lua']                     = ''
M.extentionSymbols['markdown']                = ''
M.extentionSymbols['md']                      = ''
M.extentionSymbols['mdx']                     = ''
M.extentionSymbols['mjs']                     = ''
M.extentionSymbols['mk']                      = ''
M.extentionSymbols['ml']                      = 'λ'
M.extentionSymbols['mli']                     = 'λ'
M.extentionSymbols['mustache']                = ''
M.extentionSymbols['nix']                     = ''
M.extentionSymbols['php']                     = ''
M.extentionSymbols['pl']                      = ''
M.extentionSymbols['pm']                      = ''
M.extentionSymbols['png']                     = ''
M.extentionSymbols['pp']                      = ''
M.extentionSymbols['ps1']                     = ''
M.extentionSymbols['psb']                     = ''
M.extentionSymbols['psd']                     = ''
M.extentionSymbols['py']                      = ''
M.extentionSymbols['pyc']                     = ''
M.extentionSymbols['pyd']                     = ''
M.extentionSymbols['pyo']                     = ''
M.extentionSymbols['r']                       = 'ﳒ'
M.extentionSymbols['rake']                    = ''
M.extentionSymbols['rb']                      = ''
M.extentionSymbols['rlib']                    = ''
M.extentionSymbols['rmd']                     = ''
M.extentionSymbols['rproj']                   = '鉶'
M.extentionSymbols['rs']                      = ''
M.extentionSymbols['rss']                     = ''
M.extentionSymbols['sass']                    = ''
M.extentionSymbols['scala']                   = ''
M.extentionSymbols['scss']                    = ''
M.extentionSymbols['sh']                      = ''
M.extentionSymbols['slim']                    = ''
M.extentionSymbols['sln']                     = ''
M.extentionSymbols['sol']                     = 'ﲹ'
M.extentionSymbols['sql']                     = ''
M.extentionSymbols['styl']                    = ''
M.extentionSymbols['suo']                     = ''
M.extentionSymbols['swift']                   = ''
M.extentionSymbols['t']                       = ''
M.extentionSymbols['tex']                     = 'ﭨ'
M.extentionSymbols['toml']                    = ''
M.extentionSymbols['ts']                      = ''
M.extentionSymbols['tsx']                     = ''
M.extentionSymbols['twig']                    = ''
M.extentionSymbols['txt']                     = ''
M.extentionSymbols['vim']                     = ''
M.extentionSymbols['vue']                     = '﵂'
M.extentionSymbols['webmanifest']             = ''
M.extentionSymbols['webp']                    = ''
M.extentionSymbols['xcplayground']            = ''
M.extentionSymbols['xul']                     = ''
M.extentionSymbols['yaml']                    = ''
M.extentionSymbols['yml']                     = ''
M.extentionSymbols['zsh']                     = ''
M.extentionSymbols['exe']                     = '省'
M.extentionSymbols['bin']                     = '省'

M.filenameSymbols = {}
M.filenameSymbols['bash']                     = ''
M.filenameSymbols['.bashprofile']             = ''
M.filenameSymbols['.profile']                 = ''
M.filenameSymbols['.bashrc']                  = ''
M.filenameSymbols['cmakelists.txt']           = ''
M.filenameSymbols['docker-compose.yml']       = ''
M.filenameSymbols['dockerfile']               = ''
M.filenameSymbols['dropbox']                  = ''
M.filenameSymbols['.ds_store']                = ''
M.filenameSymbols['gemfile']                  = ''
M.filenameSymbols['.gitattributes']           = ''
M.filenameSymbols['.gitconfig']               = ''
M.filenameSymbols['.gitignore']               = ''
M.filenameSymbols['.gitlab-ci.yml']           = ''
M.filenameSymbols['gruntfile.coffee']         = ''
M.filenameSymbols['gruntfile.js']             = ''
M.filenameSymbols['gruntfile.ls']             = ''
M.filenameSymbols['gulpfile.coffee']          = ''
M.filenameSymbols['gulpfile.js']              = ''
M.filenameSymbols['gulpfile.ls']              = ''
M.filenameSymbols['.gvimrc']                  = ''
M.filenameSymbols['_gvimrc']                  = ''
M.filenameSymbols['license']                  = ''
M.filenameSymbols['license.md']               = ''
M.filenameSymbols['license.markdown']         = ''
M.filenameSymbols['makefile']                 = ''
M.filenameSymbols['mix.lock']                 = ''
M.filenameSymbols['node_modules']             = ''
M.filenameSymbols['procfile']                 = ''
M.filenameSymbols['rakefile']                 = ''
M.filenameSymbols['react.jsx']                = ''
M.filenameSymbols['.vimrc']                   = ''
M.filenameSymbols['_vimrc']                   = ''
M.filenameSymbols['.zprofile']                = ''
M.filenameSymbols['.zshenv']                  = ''
M.filenameSymbols['.zshrc']                   = ''

M.directorySymbols = {}
M.directorySymbols['open']                    = ''
M.directorySymbols['closed']                  = ''
M.directorySymbols['linked']                  = ''

M.getFilenameSymbol = function(filename)
	if M.enabled then
		return M.filenameSymbols[filename]
	end
	return nil
end

M.getExtentionSymbol = function(extention)
	if M.enabled then
		return M.extentionSymbols[extention]
	end
	return nil
end

M.getDirectorySymbol = function(state)
	if M.enabled then
		return M.directorySymbols[state]
	end
	return nil
end

return M
