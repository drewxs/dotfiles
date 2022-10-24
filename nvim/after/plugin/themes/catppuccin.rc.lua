require('catppuccin').setup({
  flavour = 'mocha',
  color_overrides = {
    mocha = {
      base = '#000000',
    }
  },
  integrations = {
    nvimtree = true,
    cmp = true,
    gitsigns = true,
    telescope = true,
    treesitter = true,
    lsp_saga = true,
    mason = true,
  },
  custom_highlights = {
    NvimTreeNormal = { bg = 'NONE' },
  },
  term_colors = false,
})
