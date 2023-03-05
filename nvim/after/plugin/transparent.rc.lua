require("transparent").setup({
  enable = true, -- boolean: enable transparent
  extra_groups = { -- table/string: additional groups that should be cleared
    "NvimTreeNormal",
    "NvimTreeNormalNC",
    "Bufferline",
  },
  exclude = {}, -- table: groups you don't want to clear
})
