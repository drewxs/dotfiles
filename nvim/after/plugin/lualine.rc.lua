local colors = {
  -- general
  fg = "#a03859",
  bg = "#080808",

  -- mid
  fg_b = "#a03859",
  bg_b = "#0a0f0f",

  -- N mode
  fg_n = "#060909",
  bg_n = "#a03859",

  -- I-V-R modes
  fg_ivr = "#080c0c",
  bg_i = "#818596",
  bg_v = "#b4be82",
  bg_r = "#e2a478",
}

local custom_theme = {
  inactive = {
    c = { fg = colors.fg, bg = colors.bg },
    a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
  },
  normal = {
    c = { fg = colors.fg, bg = colors.bg },
    a = { fg = colors.fg_n, bg = colors.bg_n, gui = "bold" },
    b = { fg = colors.fg_b, bg = colors.bg_b },
  },
  insert = {
    a = { fg = colors.fg_ivr, bg = colors.bg_i, gui = "bold" },
    b = { fg = colors.fg_b, bg = colors.bg_b },
  },
  visual = {
    a = { fg = colors.fg_ivr, bg = colors.bg_v, gui = "bold" },
    b = { fg = colors.fg_b, bg = colors.bg_b },
  },
  replace = {
    a = { fg = colors.fg_ivr, bg = colors.bg_r, gui = "bold" },
    b = { fg = colors.fg_b, bg = colors.bg_b },
  },
}

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = custom_theme,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
      "encoding",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "fugitive" },
})
