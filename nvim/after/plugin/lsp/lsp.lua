local lsp = require("lsp-zero").preset({})
local nvim_lsp = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    "bashls",
    "rust_analyzer",
    "clangd",
    "omnisharp",
    "gopls",
    "jdtls",
    "lua_ls",
    "elixirls",
    "tsserver",
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
    "bufls",
  },
  automatic_installation = true,
  handlers = { lsp.default_setup },
})

local capabilities = cmp_nvim_lsp.default_capabilities()
local installed_servers = mason_lspconfig.get_installed_servers()

for _, server in ipairs(installed_servers) do
  nvim_lsp[server].setup({ capabilities })
end

nvim_lsp.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "require", "xdg_open" },
      },
    },
  },
})

nvim_lsp.clangd.setup({
  cmd = { "clangd", "--offset-encoding=utf-16" },
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
})
