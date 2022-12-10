local status, _ = pcall(require, "lspconfig")
if not status then
  return
end

require("lsp.handlers").setup()
require("lsp.mason")
require("lsp.lspconfig")
require("lsp.lspsaga")
require("lsp.null-ls")
require("lsp.cmp")
