require("catppuccin").setup({
  flavour = "mocha",
  color_overrides = {
    mocha = {
      rosewater = "#5fd3c0",
      flamingo = "#37c8b0",
      pink = "#e5aeb1",
      mauve = "#cdd3fe",
      red = "#f38ba8",
      maroon = "#eba0ac",
      peach = "#b5b4c9",
      yellow = "#aecbf2",
      green = "#659ea2",
      teal = "#7dc2c7",
      sky = "#94d7db",
      sapphire = "#a0b9d8",
      blue = "#8296b0",
      lavender = "#b5b4c9",

      text = "#a6adc8",
      subtext1 = "#a6adc8",
      subtext0 = "#9399b2",
      overlay2 = "#7f849c",
      overlay1 = "#686c82",
      overlay0 = "#6c7086",
      surface2 = "#585b70",
      surface1 = "#45475a",
      surface0 = "#313244",

      base = "#0a0a0f",
      mantle = "#020203",
      crust = "#000000",

      none = "NONE",
    },
  },
  custom_highlights = function(colors)
    return {
      NvimTreeNormal = { bg = colors.none },
      Bufferline = { bg = colors.none },
    }
  end,
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  transparency = true,
  term_colors = true,
  integrations = {
    nvimtree = true,
    cmp = true,
    gitsigns = true,
    telescope = true,
    treesitter = true,
    lsp_saga = true,
    mason = true,
    which_key = true,
    markdown = true,
    bufferline = true,
    lightspeed = true,
  },
})
