local M = {}

M.default_extentionSymbol = ''
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

M.default_filenameSymbol = ''
M.filenameSymbols = {}
M.filenameSymbols['bash']                     = ''
M.filenameSymbols['zsh']                      = ''
M.filenameSymbols['fish']                     = ''
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
M.filenameSymbols['LICENSE']                  = ''
M.filenameSymbols['LICENSE.md']               = ''
M.filenameSymbols['LICENSE.markdown']         = ''
M.filenameSymbols['makefile']                 = ''
M.filenameSymbols['Makefile']                 = ''
M.filenameSymbols['MAKEFILE']                 = ''
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

M.default_directorySymbol = ''
M.directorySymbols = {}
M.directorySymbols['open']                    = ''
M.directorySymbols['closed']                  = ''
M.directorySymbols['linked']                  = ''

M.iconsColorDicts = {}
M.iconsColorDicts['Brown'] = {''}
M.iconsColorDicts['Aqua'] = {''}
M.iconsColorDicts['Blue'] = {'', '', '', '', '', '', '', '', '', '', ''}
M.iconsColorDicts['DarkBlue'] = {'', '', '', '', ''}
M.iconsColorDicts['Purple'] = {'', '', '', '', '', '', ''}
M.iconsColorDicts['Red'] = {'', '', '', ''}
M.iconsColorDicts['Yellow'] = {'', ''}
M.iconsColorDicts['Orange'] = {'', '', '', '', '', '', '', '', '', 'λ', '', '', ''}
M.iconsColorDicts['Pink'] = {'', ''}
M.iconsColorDicts['Salmon'] = {'', ''}
M.iconsColorDicts['Green'] = {'', '', '', '', '', '', '', ''}
M.iconsColorDicts['LightGreen'] = {'﵂'}
M.iconsColorDicts['Grey'] = {'', '', '', ''}
M.iconsColorDicts['White'] = {'', '', '', ''}

-- these for loops set the values inside each dict to keys so we could check
-- if a specific value is indise there by checking if dict[value] isn't nil
for key, _ in pairs(M.iconsColorDicts) do
	local table = M.iconsColorDicts[key]
	for _, l in ipairs(table) do M.iconsColorDicts[key][l] = true end
end

M.getColorOfSymbol = function(symbol)
	for color, dict in pairs(M.iconsColorDicts) do
		if dict[symbol] then
			return color
		end
	end
	return nil
end

M.getFilenameSymbol = function(filename)
	return M.filenameSymbols[filename]
end

M.getExtentionSymbol = function(extention)
	return M.extentionSymbols[extention]
end

M.getDirectorySymbol = function(state)
	return M.directorySymbols[state]
end

return M
