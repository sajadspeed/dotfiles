local wezterm = require("wezterm")

local mux = wezterm.mux

local config = dofile("/home/sajadspeed/.config/wezterm/wezterm.lua")

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.window_decorations = "NONE"
config.enable_tab_bar = false

return config
