local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
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
    "sqruff",
    "prismals",
    "dockerls",
    "docker_compose_language_service",
    "terraformls",
    "marksman",
    "taplo",
    "buf_ls",
    "autotools_ls",
    "intelephense",
  },
})

vim.lsp.config("*", {
  capabilities = cmp_nvim_lsp.default_capabilities(),
})

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  severity_sort = true,
})
