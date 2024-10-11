local wezterm = require("wezterm")

local is_linux = wezterm.target_triple:find("linux") ~= nil

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
      source = {
        Gradient = {
          orientation = "Vertical",
          interpolation = "Linear",
          blend = "Rgb",
          colors = { "#070a0d", "#111417" },
        },
      },
      opacity = 0.93,
      width = "100%",
      height = "100%",
    },
  },
  macos_window_background_blur = 10,
  keys = {
    { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "q", mods = "CTRL|ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
  },
}

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  local screen = wezterm.gui:screens().active
  if screen.width < 2400 then
    window:gui_window():maximize()
  end
end)

wezterm.on("window-focus-changed", function()
  if is_linux then
    os.execute([[xdotool search -classname org.wezfurlong.wezterm \
    | xargs -I{} xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id {}
    ]])
  end
end)

return config
