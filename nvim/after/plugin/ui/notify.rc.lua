require("notify").setup({
  background_colour = "#080808",
  render = "default",
  stages = "fade",
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  fps = 60,
  level = 2,
  minimum_width = 50,
  max_width = 50,
  timeout = 3000,
  top_down = true,
})
