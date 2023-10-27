require("catppuccin").setup({
  flavour = "mocha",
  color_overrides = {
    all = {
      text = "#a1a8c3",
      subtext1 = "#a6adc8",
      subtext0 = "#9399b2",
      overlay2 = "#7f849c",
      overlay1 = "#686c82",
      overlay0 = "#646787",
      surface2 = "#555878",
      surface1 = "#222332",
      surface0 = "#0a0d0f",
      base = "#0a0a0f",
      mantle = "#020203",
      crust = "#000000",
      none = "NONE",
    },
    mocha = {
      rosewater = "#6fb5a5",
      flamingo = "#bf616a",
      pink = "#c98d90",
      mauve = "#697892",
      red = "#9f626e",
      maroon = "#c48b8f",
      peach = "#8c9ea3",
      yellow = "#c1747f",
      green = "#7f9a7e",
      teal = "#5b828c",
      sky = "#5e5f6e",
      sapphire = "#3e586e",
      blue = "#8296a6",
      lavender = "#82829b",
    },
    macchiato = {
      rosewater = "#e2d4cc",
      flamingo = "#d8c1bd",
      pink = "#d4b0c7",
      mauve = "#b39ead",
      red = "#b2828f",
      maroon = "#a4747f",
      peach = "#c19b82",
      yellow = "#d18c8c",
      green = "#7f9a7e",
      teal = "#769b96",
      sky = "#6f8d9e",
      sapphire = "#5e7486",
      blue = "#72809e",
      lavender = "#a5a3b3",
    },
    frappe = {
      rosewater = "#6fb5a5",
      flamingo = "#bf616a",
      pink = "#a3be8c",
      mauve = "#d08770",
      red = "#ebcb8b",
      maroon = "#b48ead",
      peach = "#d8dee9",
      yellow = "#eceff4",
      green = "#8fbcbb",
      teal = "#88c0d0",
      sky = "#81a1c1",
      sapphire = "#5e81ac",
      blue = "#eceff4",
      lavender = "#8d8caf",
    },
    latte = {
      rosewater = "#3c3f4a",
      flamingo = "#eba0ac",
      pink = "#c2b59b",
      mauve = "#cf8164",
      red = "#8296b0",
      maroon = "#a18daf",
      peach = "#659ea2",
      yellow = "#b5b4c9",
      green = "#76a065",
      teal = "#eba0ac",
      sky = "#c2b59b",
      sapphire = "#cf8164",
      blue = "#8296b0",
      lavender = "#a18daf",
    },
  },
  custom_highlights = function(colors)
    return {
      Bufferline = { bg = colors.none },
      NvimTreeNormal = { bg = colors.none },
      NvimTreeFolderIcon = { fg = colors.surface2 },
      NvimTreeFolderName = { fg = colors.surface2 },
      NvimTreeEmptyFolderIcon = { fg = colors.surface2 },
      NvimTreeEmptyFolderName = { fg = colors.surface2 },
      NvimTreeOpenedFolderName = { fg = colors.flamingo },
      NvimTreeOpenedFolderIcon = { fg = colors.flamingo },
    }
  end,
  transparent_background = true,
  term_colors = true,
  integrations = {
    nvimtree = true,
    cmp = true,
    gitsigns = true,
    telescope = { enabled = true },
    treesitter = true,
    lsp_saga = true,
    mason = true,
    which_key = true,
    markdown = true,
    lightspeed = true,
    noice = true,
    notify = true,
  },
})
