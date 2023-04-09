-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Font 1/2
local font_name = "Caskaydia Cove Nerd Font"
local generate_chosen_font = function (name, params)

	-- disable / enable ligatures by uncommenting / commenting the next line
	-- params.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

	return wezterm.font (name, params)
end

local config = {
	-- Yes, leave this even if it's your default anyways...
	default_prog = { '/bin/bash' },

	-- Font 2/2
	font = generate_chosen_font(font_name),
	font_rules = {
		{
			italic = true,
			font = generate_chosen_font(font_name, { italic = true }),
		},
		{
			intensity = "Bold",
			font = generate_chosen_font(font_name, { bold = true }),
		},
	},
	warn_about_missing_glyphs = false,
	font_size = 11,

	color_scheme = 'One Half Black (Gogh)',

	-- Cursor style
	default_cursor_style = "SteadyBlock",
	force_reverse_video_cursor = true,

	-- Tab Bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,

	-- Window
	window_background_opacity = 0.7,
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},

	-- Keybinds
	keys = {
		{
			key = [[\]],
			mods = "CTRL|ALT",
			action = wezterm.action({
				SplitHorizontal = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = [[\]],
			mods = "CTRL",
			action = wezterm.action({
				SplitVertical = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = "q",
			mods = "CTRL",
			action = wezterm.action({ CloseCurrentPane = { confirm = false } }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Left" }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Right" }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Up" }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Down" }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
		},
		{ -- browser-like bindings for tabbing
			key = "t",
			mods = "CTRL",
			action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "CTRL",
			action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
		},
		{
			key = "Tab",
			mods = "CTRL",
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivateTabRelative = -1 }),
		}, -- standard copy/paste bindings
		{
			key = "x",
			mods = "CTRL",
			action = "ActivateCopyMode",
		},
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ PasteFrom = "Clipboard" }),
		},
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
		},
	},
}

-- and finally, return the configuration to wezterm
return config
