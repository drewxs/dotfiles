require("catppuccin").setup({
  flavour = "mocha",
  color_overrides = {
    mocha = {
      base = "#000000",
    },
  },
  transparency = true,
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
  },
  custom_highlights = {
    NvimTreeNormal = { bg = "NONE" },
    Bufferlin = { bg = "NONE" },
  },
  term_colors = false,
})
