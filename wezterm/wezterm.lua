local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "OneDark (base16)"

config.bidi_enabled = true
config.font = wezterm.font_with_fallback({
	"Mononoki Nerd Font Mono",
	"Vazir Code",
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 12
config.enable_tab_bar = false
config.line_height = 1.1

config.adjust_window_size_when_changing_font_size = false

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.keys = {

	{
		key = "mapped:H",
		mods = "CTRL|SHIFT",
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
}

return config
