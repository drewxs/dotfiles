vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

require("options")
require("plugins")
require("lsp")
require("maps")
require("base")
