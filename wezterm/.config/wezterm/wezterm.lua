-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

wezterm.on('toggle-ligature', function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.harfbuzz_features then
		-- If we haven't overridden it yet, then override with ligatures disabled
		overrides.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
	else
		-- else we did already, and we should disable out override now
		overrides.harfbuzz_features = nil
	end
	window:set_config_overrides(overrides)
end)

-- Font 1/2
local font_name = "Caskaydia Cove Nerd Font"
local generate_chosen_font = function (name, params)
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
	bold_brightens_ansi_colors = true,

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
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	-- Keybinds
	disable_default_key_bindings = true,
	keys = {
		-- toggle ligatures
		{ key = "l", mods = "CTRL|SHIFT|ALT", action = act.EmitEvent 'toggle-ligature', },
		-- split
		{ key = [[\]], mods = "CTRL|ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" }, }), },
		{ key = [[\]], mods = "CTRL", action = act({ SplitVertical = { domain = "CurrentPaneDomain" }, }), },
		-- { key = "q", mods = "CTRL", action = act({ CloseCurrentPane = { confirm = false } }), },
		{ key = "h", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Left" }), },
		{ key = "l", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Right" }), },
		{ key = "k", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Up" }), },
		{ key = "j", mods = "CTRL|SHIFT", action = act({ ActivatePaneDirection = "Down" }), },
		-- { key = "h", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Left", 1 } }), },
		-- { key = "l", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Right", 1 } }), },
		-- { key = "k", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Up", 1 } }), },
		-- { key = "j", mods = "CTRL|SHIFT|ALT", action = act({ AdjustPaneSize = { "Down", 1 } }), },
		-- browser-like bindings for tabbing
		--[[
		{ key = "t", mods = "CTRL", action = act({ SpawnTab = "CurrentPaneDomain" }), },
		{ key = "w", mods = "CTRL", action = act({ CloseCurrentTab = { confirm = false } }), },
		{ key = "Tab", mods = "CTRL", action = act({ ActivateTabRelative = 1 }), },
		{ key = "Tab", mods = "CTRL|SHIFT", action = act({ ActivateTabRelative = -1 }), },
		--]]
		-- standard copy/paste bindings
		{ key = "v", mods = "CTRL|SHIFT", action = act({ PasteFrom = "Clipboard" }), },
		{ key = "c", mods = "CTRL|SHIFT", action = act({ CopyTo = "ClipboardAndPrimarySelection" }), },
		-- font size
		{ key = '0', mods = 'CTRL', action = act.ResetFontSize },
		{ key = '0', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
		{ key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
		{ key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
		{ key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
		{ key = '=', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
		{ key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
		{ key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
	},
}

-- and finally, return the configuration to wezterm
return config
