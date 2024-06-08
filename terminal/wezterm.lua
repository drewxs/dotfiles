local wezterm = require("wezterm")

local config = {
  enable_tab_bar = false,
  audible_bell = "Disabled",
  notification_handling = "NeverShow",
  window_close_confirmation = "NeverPrompt",
  warn_about_missing_glyphs = false,
  color_scheme = "Terminix Dark (Gogh)",
  font = wezterm.font("SauceCodePro Nerd Font Mono", { weight = "Medium" }),
  font_size = 14.0,
  max_fps = 240,
  animation_fps = 60,
  background = {
    {
      source = { File = os.getenv("HOME") .. "/.dotfiles/terminal/assets/bg-1.jpg" },
      hsb = { brightness = 0.03 },
      opacity = 0.9,
      vertical_align = "Top",
      horizontal_align = "Center",
    },
  },
  keys = {
    { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
  },
}

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config
