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
	-- #F14C28
	["c_F14C28"] = { '', },
	-- #019833
	["c_019833"] = { '', },
	-- #DEA584
	["c_DEA584"] = { '', },
	-- #E44D26
	["c_E44D26"] = { '', },
	-- #F69A1B
	["c_F69A1B"] = { '', '',},
	-- #9772FB
	["c_9772FB"] = { '∞', '', },
	-- #E8274B
	["c_E8274B"] = { '', '', },
	-- #F1E05A
	["c_F1E05A"] = { '', '', },
	-- #1563FF
	["c_1563FF"] = { '', '', },
	-- #185ABD
	["c_185ABD"] = { '⚙', '', },
	-- #41535B
	["c_41535B"] = { '', '', },
	-- #B83998
	["c_B83998"] = { '', '', },
	-- #E34C26
	["c_E34C26"] = { '', '', },
	-- #358A5B
	["c_358A5B"] = { '鉶', 'ﳒ', },
	-- #427819
	["c_427819"] = { '', '', 'ﭨ', },
	-- #563D7C
	["c_563D7C"] = { '', '', '', },
	-- #599EFF
	["c_599EFF"] = { '', '', '', },
	-- #CC3E44
	["c_CC3E44"] = { '', '', '', },
	-- #F88A02
	["c_F88A02"] = { '𝙆', '', '', },
	-- #FFA61A
	["c_FFA61A"] = { 'ﰟ', '', '', },
	-- #E4B854
	["c_E4B854"] = { '', '', '', },
	-- #D0BF41
	["c_D0BF41"] = { 'ﬥ', '', '', '', '', '', },
	-- #6D8086
	["c_6D8086"] = { '', '', '', '', '', '', },
	-- #A074C4
	["c_A074C4"] = { '', '', '', '', '', '', '', '', },
	-- #E37933
	["c_E37933"] = { '謹', 'λ', '', '', '', '', '', '', },
	-- #8DC149
	["c_8DC149"] = { '', '', '﵂', '', '', '', '', '', '', },
	-- #ECECEC
	["c_ECECEC"] = { '', '卑', 'ﲉ', '龎', '', '', '', '', '', },
	-- #51A0CF
	["c_51A0CF"] = { 'ﰩ', 'ﲹ', '', '', '', '', '', '', '', '', '', '', '', },
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
