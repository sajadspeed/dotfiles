-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()


config.color_scheme = 'OneDark (base16)'

config.bidi_enabled=true
-- config.font = wezterm.font("Mononoki Nerd Font Mono")
config.font = wezterm.font_with_fallback {
  "Mononoki Nerd Font Mono",
  'Vazir Code',
}
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 12
config.enable_tab_bar = false
config.line_height = 1.1

-- config.bidi_direction = "AutoLeftToRight"
config.adjust_window_size_when_changing_font_size = false

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}



-- and finally, return the configuration to wezterm
return config
