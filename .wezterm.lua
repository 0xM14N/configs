local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config = {
	color_scheme='Nord (Gogh)',
	enable_tab_bar=false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	default_cursor_style="BlinkingBar",
	font = wezterm.font("JetBrains Mono",{ weight="Bold"}),
	font_size = 12.5,
  	default_prog = {"wsl.exe", "--distribution", "Ubuntu"},

  	-- Configure window padding
  	window_padding = {
  	  left = 0,
  	  right = 0,
  	  top = 0,
  	  bottom = 0,
  	},
 	 keys = {
    -- Split horizontally with Ctrl+Shift+H
{
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
    {key="H", mods="CTRL|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    -- Split vertically with Ctrl+Shift+V
    {key="V", mods="CTRL|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    -- Close current pane with Ctrl+Shift+W
    {key="W", mods="CTRL|SHIFT", action=wezterm.action{CloseCurrentPane={confirm=true}}},
      {key="1", mods="CTRL", action=wezterm.action{ActivateTab=0}},
    {key="2", mods="CTRL", action=wezterm.action{ActivateTab=1}},
    {key="3", mods="CTRL", action=wezterm.action{ActivateTab=2}},
    {key="4", mods="CTRL", action=wezterm.action{ActivateTab=3}},
    {key="5", mods="CTRL", action=wezterm.action{ActivateTab=4}},
    {key="6", mods="CTRL", action=wezterm.action{ActivateTab=5}},
    {key="7", mods="CTRL", action=wezterm.action{ActivateTab=6}},
    {key="8", mods="CTRL", action=wezterm.action{ActivateTab=7}},
    {key="9", mods="CTRL", action=wezterm.action{ActivateTab=8}},
  },
  -- Set the window background opacity
  window_background_opacity = 1,

window_background_image = "C:\\Users\\User\\Downloads\\lol3.jpg",

  window_background_image_hsb = {
    brightness = 0.35,
    hue = 1.0,
    saturation = 1,
  },
}

return config
