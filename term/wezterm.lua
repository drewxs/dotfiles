local wezterm = require("wezterm")

local config = {
  enable_tab_bar = false,
  audible_bell = "Disabled",
  notification_handling = "NeverShow",
  window_close_confirmation = "NeverPrompt",
  warn_about_missing_glyphs = false,
  color_scheme = "Shaman (Gogh)",
  font = wezterm.font("SauceCodePro Nerd Font Mono", { weight = "Medium" }),
  font_size = 15.0,
  max_fps = 240,
  animation_fps = 100,
  window_background_gradient = {
    colors = { "#000306", "#0a0d10" },
    orientation = { Linear = { angle = -45.0 } },
  },
  window_background_opacity = 0.95,
  macos_window_background_blur = 10,
  disable_default_key_bindings = true,
  keys = {
    { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
    { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
    { key = "n", mods = "CTRL|SHIFT", action = wezterm.action.SpawnWindow },
    { key = "Enter", mods = "ALT", action = wezterm.action.ToggleFullScreen },
  },
}

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  local screen = wezterm.gui:screens().active
  if screen.width < 2400 then
    window:gui_window():maximize()
  end
end)

return config
