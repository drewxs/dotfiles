local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local servers = {
  "bashls",
  "rust_analyzer",
  "zls",
  "clangd",
  "omnisharp",
  "gopls",
  "jdtls",
  "lua_ls",
  "elixirls",
  "pyright",
  "solargraph",
  "eslint",
  "html",
  "cssls",
  "cssmodules_ls",
  "tailwindcss",
  "jsonls",
  "graphql",
  "sqlls",
  "prismals",
  "dockerls",
  "docker_compose_language_service",
  "terraformls",
  "marksman",
  "taplo",
  "buf_ls",
  "autotools_ls",
}

mason.setup()
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

vim.lsp.config("*", {
  capabilities = cmp_nvim_lsp.default_capabilities(),
})

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
})
