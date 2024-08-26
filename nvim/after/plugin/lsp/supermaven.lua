local supermaven = require("supermaven-nvim")
local api = require("supermaven-nvim").api

supermaven.setup({
  log_level = "off",
  keymaps = {
    accept_word = "<c-f>",
  },
})

api.use_free_version()
