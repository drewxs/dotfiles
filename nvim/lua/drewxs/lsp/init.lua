local status, _ = pcall(require, "lspconfig")
if not status then
  return
end

require("drewxs.lsp.handlers").setup()
require("drewxs.lsp.mason")
require("drewxs.lsp.lspconfig")
require("drewxs.lsp.lspsaga")
require("drewxs.lsp.null-ls")
require("drewxs.lsp.cmp")
