local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Breeze (Gogh)"

config.bidi_enabled = true
config.font = wezterm.font_with_fallback({
	{ family = "Mononoki Nerd Font Mono", weight = "Regular" },
	"Vazir Code",
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 12

-- Just like Konsole
config.line_height = 1.1
config.cell_width = 0.8
--

config.window_padding = {
	left = 4,
	right = 4,
	top = 2,
	bottom = 2,
}

-- config.hide_tab_bar_if_only_one_tab = true

config.adjust_window_size_when_changing_font_size = false

config.max_fps = 180
config.animation_fps = 180

config.initial_cols = 135
config.initial_rows = 32

config.warn_about_missing_glyphs = false

config.keys = {

	{
		mods = "CTRL|SHIFT",
		key = "mapped:H",
		action = wezterm.action.SendString("\\u4E9C"),
	},
	{
		key = "mapped:H",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SendString("鳥"),
	},
	{
		key = "mapped:L",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SendString("\\u65E5"),
	},
	{
		key = "mapped:L",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SendString("月"),
	},
	{
		key = "mapped:J",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SendString("\\u56FD"),
	},
	{
		key = "mapped:K",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SendString("\\u5C71"),
	},
	{
		key = "mapped:,",
		mods = "CTRL",
		action = wezterm.action.SendString("\\u9F8D"),
	},
	{
		key = "mapped:.",
		mods = "CTRL",
		action = wezterm.action.SendString("\\u99AC"),
	},

	{ key = "M", mods = "CTRL|SHIFT", action = wezterm.action.ToggleFullScreen },
}

return config
