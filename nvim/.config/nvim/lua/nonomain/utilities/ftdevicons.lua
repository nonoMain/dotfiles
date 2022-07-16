local utils = require("nonomain.utilities.utils")
local fn = vim.fn
local M = {}

M.default_extentionSymbol = ''

M.names = {
	["fish"]                     = '',
	["zsh"]                      = '',
	["bash"]                     = '',
	[".zprofile"]                = '',
	[".zshenv"]                  = '',
	[".zshrc"]                   = '',
	[".bash_profile"]            = '',
	[".bashprofile"]             = '',
	[".profile"]                 = '',
	[".bashrc"]                  = '',
	[".editorconfig"]            = '',
	["cmakelists.txt"]           = '',
	["docker-compose.yml"]       = '',
	["dockerfile"]               = '',
	["dropbox"]                  = '',
	[".ds_store"]                = '',
	["gemfile"]                  = '',
	[".npmignore"]               = '',
	[".npmrc"]                   = '',
	[".gitmodules"]              = '',
	[".gitattributes"]           = '',
	[".gitconfig"]               = '',
	[".gitignore"]               = '',
	[".gitlab-ci.yml"]           = '',
	["commit_editmsg"]           = '',
	["gruntfile.coffee"]         = '',
	["gruntfile.js"]             = '',
	["gruntfile.ls"]             = '',
	["gulpfile.coffee"]          = '',
	["gulpfile.js"]              = '',
	["gulpfile.ls"]              = '',
	[".gvimrc"]                  = '',
	["_gvimrc"]                  = '',
	["readme"]                   = '',
	["readme.md"]                = '',
	["readme.markdown"]          = '',
	["license"]                  = '',
	["license.md"]               = '',
	["license.markdown"]         = '',
	["copying"]                  = '',
	["copying.lesser"]           = '',
	["makefile"]                 = '',
	["mix.lock"]                 = '',
	["node_modules"]             = '',
	["procfile"]                 = '',
	["rakefile"]                 = '',
	["react.jsx"]                = '',
	[".vimrc"]                   = '',
	["_vimrc"]                   = '',
	[".settings.json"]           = '',
	["brewfile"]                 = '',
}

M.extentions = {
	["sh"]                       = '',
	["bash"]                     = '',
	["fish"]                     = '',
	["awk"]                      = '',
	["bat"]                      = '',
	["ai"]                       = '',
	["bmp"]                      = '',
	["c"]                        = '',
	["c++"]                      = '',
	["cp"]                       = '',
	["cpp"]                      = '',
	["cc"]                       = '',
	["cxx"]                      = '',
	["h"]                        = '',
	["hh"]                       = '',
	["hpp"]                      = '',
	["hxx"]                      = '',
	["clj"]                      = '',
	["cljc"]                     = '',
	["cljs"]                     = '',
	["coffee"]                   = '',
	["conf"]                     = '',
	["cs"]                       = '',
	["csh"]                      = '',
	["d"]                        = '',
	["dart"]                     = '',
	["db"]                       = '',
	["diff"]                     = '',
	["dump"]                     = '',
	["edn"]                      = '',
	["eex"]                      = '',
	["ejs"]                      = '',
	["elm"]                      = '',
	["erl"]                      = '',
	["ex"]                       = '',
	["exs"]                      = '',
	["f#"]                       = '',
	["fs"]                       = '',
	["fsi"]                      = '',
	["fsscript"]                 = '',
	["fsx"]                      = '',
	["gemspec"]                  = '',
	["gif"]                      = '',
	["go"]                       = '',
	["haml"]                     = '',
	["hbs"]                      = '',
	["hrl"]                      = '',
	["hs"]                       = '',
	["htm"]                      = '',
	["html"]                     = '',
	["css"]                      = '',
	["ico"]                      = '',
	["ini"]                      = '',
	["java"]                     = '',
	["jl"]                       = '',
	["jpeg"]                     = '',
	["jpg"]                      = '',
	["js"]                       = '',
	["json"]                     = '',
	["jsx"]                      = '',
	["ksh"]                      = '',
	["leex"]                     = '',
	["less"]                     = '',
	["lhs"]                      = '',
	["lua"]                      = '',
	["markdown"]                 = '',
	["md"]                       = '',
	["mdx"]                      = '',
	["rmd"]                      = '',
	["mjs"]                      = '',
	["mk"]                       = '',
	["ml"]                       = 'λ',
	["mli"]                      = 'λ',
	["mustache"]                 = '',
	["nix"]                      = '',
	["php"]                      = '',
	["pl"]                       = '',
	["pm"]                       = '',
	["png"]                      = '',
	["pp"]                       = '',
	["ps1"]                      = '',
	["psb"]                      = '',
	["psd"]                      = '',
	["py"]                       = '',
	["pyc"]                      = '',
	["pyd"]                      = '',
	["pyo"]                      = '',
	["r"]                        = 'ﳒ',
	["rake"]                     = '',
	["rb"]                       = '',
	["rlib"]                     = '',
	["rproj"]                    = '鉶',
	["rs"]                       = '',
	["rss"]                      = '',
	["sass"]                     = '',
	["scala"]                    = '',
	["scss"]                     = '',
	["slim"]                     = '',
	["sln"]                      = '',
	["sol"]                      = 'ﲹ',
	["sql"]                      = '',
	["styl"]                     = '',
	["suo"]                      = '',
	["t"]                        = '',
	["tex"]                      = 'ﭨ',
	["toml"]                     = '',
	["ts"]                       = '',
	["tsx"]                      = '',
	["twig"]                     = '',
	["txt"]                      = '',
	["vim"]                      = '',
	["vue"]                      = '﵂',
	["webmanifest"]              = '',
	["webp"]                     = '',
	["swift"]                    = '',
	["xcplayground"]             = '',
	["xul"]                      = '',
	["yaml"]                     = '',
	['yml']                      = '',
	["exe"]                      = '省',
	["bin"]                      = '省',
	["snippets"]                 = '',
	["import"]                   = '',
}

M.default_filenameSymbol = ''
M.filenameSymbols = {}

M.default_directorySymbol = ''
M.directorySymbols = {}
M.directorySymbols["open"]                    = ''
M.directorySymbols["closed"]                  = ''
M.directorySymbols["linked"]                  = ''

M.iconsColorDicts = {
	-- #000000
	["c_000000"] = { '', },
	-- #005CA5
	["c_005CA5"] = { '⚙', },
	-- #0061FE
	["c_0061FE"] = { '', },
	-- #019833
	["c_019833"] = { '', },
	-- #03589C
	["c_03589C"] = { '', },
	-- #1563FF
	["c_1563FF"] = { '', },
	-- #185ABD
	["c_185ABD"] = { '', },
	-- #207245
	["c_207245"] = { '', },
	-- #358A5B
	["c_358A5B"] = { '鉶', 'ﳒ', },
	-- #384D54
	["c_384D54"] = { '', },
	-- #3D6117
	["c_3D6117"] = { 'ﭨ', },
	-- #41535B
	["c_41535B"] = { '', },
	-- #427819
	["c_427819"] = { '', },
	-- #42A5F5
	["c_42A5F5"] = { '', },
	-- #519ABA
	["c_519ABA"] = { 'ﰩ', 'ﲹ', '', '', '', '', '', '', '', '', '', '', },
	-- #51A0CF
	["c_51A0CF"] = { '', '', },
	-- #563D7C
	["c_563D7C"] = { '', '', '', },
	-- #596706
	["c_596706"] = { '', },
	-- #599EFF
	["c_599EFF"] = { '', '', },
	-- #6D8086
	["c_6D8086"] = { '', '', '', '', '', },
	-- #701516
	["c_701516"] = { '', },
	-- #7EBAE4
	["c_7EBAE4"] = { '', },
	-- #854CC7
	["c_854CC7"] = { '', },
	-- #87C095
	["c_87C095"] = { '', },
	-- #89E051
	["c_89E051"] = { '', '', '', },
	-- #8DC149
	["c_8DC149"] = { '', '', '﵂', '', '', '', },
	-- #9772FB
	["c_9772FB"] = { '∞', },
	-- #A074C4
	["c_A074C4"] = { '', '', '', '', '', '', '', },
	-- #A270BA
	["c_A270BA"] = { '', },
	-- #B30B00
	["c_B30B00"] = { '', },
	-- #B83998
	["c_B83998"] = { '', '', },
	-- #BBBBBB
	["c_BBBBBB"] = { '', },
	-- #CB4A32
	["c_CB4A32"] = { '', },
	-- #CC3E44
	["c_CC3E44"] = { '', '', '', },
	-- #D0BF41
	["c_D0BF41"] = { 'ﬥ', '', '', '', '', '', },
	-- #DEA584
	["c_DEA584"] = { '', },
	-- #E24329
	["c_E24329"] = { '', },
	-- #E34C26
	["c_E34C26"] = { '', },
	-- #E37933
	["c_E37933"] = { '謹', 'λ', '', '', '', '', '', '', },
	-- #E44D26
	["c_E44D26"] = { '', },
	-- #E4B854
	["c_E4B854"] = { '', },
	-- #E8274B
	["c_E8274B"] = { '', '', },
	-- #ECECEC
	["c_ECECEC"] = { '', '', },
	-- #F14C28
	["c_F14C28"] = { '', },
	-- #F1E05A
	["c_F1E05A"] = { '', '', },
	-- #F55385
	["c_F55385"] = { '', },
	-- #F69A1B
	["c_F69A1B"] = { '', },
	-- #F88A02
	["c_F88A02"] = { '𝙆', '', },
	-- #FAF743
	["c_FAF743"] = { '', },
	-- #FB9D3B
	["c_FB9D3B"] = { '', },
	-- #FF3E00
	["c_FF3E00"] = { '', },
	-- #FFA61A
	["c_FFA61A"] = { '', },
	-- #FFAFAF
	["c_FFAFAF"] = { '', },
	-- #FFB13B
	["c_FFB13B"] = { 'ﰟ', '', },
	-- #FFE291
	["c_FFE291"] = { '', '', },
	-- #FFFFFF
	["c_FFFFFF"] = { '', '卑', 'ﲉ', '龎', '', '', '' },
}

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
	return M.names[filename]
end

M.getExtentionSymbol = function(extention)
	return M.extentions[extention]
end

M.getDirectorySymbol = function(state)
	return M.directorySymbols[state]
end

M.getPathSymbol = function(path)
	if utils.is_dir(path) then
		return M.default_directorySymbol
	else
		return M.names[fn.fnamemodify(path, ":t")] or  M.extentions[fn.fnamemodify(path, ":e")] or M.default_extentionSymbol
	end
end

return M
