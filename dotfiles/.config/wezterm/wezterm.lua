local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.enable_wayland = false
config.front_end = "WebGpu"

return config
