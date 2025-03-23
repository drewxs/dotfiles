local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local lspconfig_defaults = lspconfig.util.default_config
lspconfig_defaults.capabilities =
  vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, cmp_nvim_lsp.default_capabilities())

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
  handlers = { lsp.default_setup },
})

local installed_servers = mason_lspconfig.get_installed_servers()
local capabilities = cmp_nvim_lsp.default_capabilities()

for _, server in ipairs(installed_servers) do
  lspconfig[server].setup({ capabilities })
end

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "require", "xdg_open" },
      },
    },
  },
})

lspconfig.clangd.setup({
  cmd = { "clangd", "--offset-encoding=utf-16" },
})

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = { spacing = 5 },
  update_in_insert = true,
})
