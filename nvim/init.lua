vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

require("drewxs/options")
require("drewxs/plugins")
require("drewxs/lsp")
require("drewxs/maps")
require("drewxs/base")
