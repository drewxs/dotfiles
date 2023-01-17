local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

saga.setup({
  ui = {
    theme = "round", -- currently only round theme
    border = "single", -- "single" | "double" | "rounded" | "solid" | "shadow"
    winblend = 0,
    expand = "",
    collapse = "",
    preview = " ",
    code_action = "💡",
    diagnostic = "🐞",
    incoming = " ",
    outgoing = " ",
    colors = {
      normal_bg = "#070709", --float window normal background color
      title_bg = "#080808", --title background color
      red = "#714243",
      magenta = "#817a99",
      orange = "#008484",
      yellow = "#008484",
      green = "#006353",
      cyan = "#008484",
      blue = "#00c3d4",
      purple = "#817a99",
      white = "#008484",
      black = "#080808",
    },
    kind = {},
  },
  lightbulb = {
    enable = true,
    enable_in_insert = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder = {
    edit = { "o", "<CR>" },
    vsplit = "s",
    split = "i",
    tabe = "t",
    quit = { "q", "<ESC>" },
  },
  code_action = {
    num_shortcut = true,
    keys = {
      quit = "q",
      exec = "<CR>",
    },
  },
  definition = {
    edit = "<C-c>o",
    vsplit = "<C-c>v",
    split = "<C-c>i",
    tabe = "<C-c>t",
    quit = "q",
    close = "<Esc>",
  },
  diagnostic = {
    show_code_action = true,
    show_source = true,
    jump_num_shortcut = true,
    keys = {
      exec_action = "o",
      quit = "q",
      go_action = "g",
    },
  },
  rename = {
    quit = "<C-c>",
    exec = "<CR>",
    mark = "x",
    confirm = "<CR>",
    in_select = true,
    whole_project = true,
  },
  symbol_in_winbar = {
    enable = true,
    separator = " ",
    hide_keyword = true,
    show_file = true,
    folder_level = 2,
    respect_root = false,
    color_mode = false,
  },
  outline = {
    win_position = "right",
    win_with = "",
    win_width = 30,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      jump = "o",
      expand_collapse = "u",
      quit = "q",
    },
  },
  callhierarchy = {
    show_detail = false,
    keys = {
      edit = "e",
      vsplit = "s",
      split = "i",
      tabe = "t",
      jump = "o",
      quit = "q",
      expand_collapse = "u",
    },
  },
})
