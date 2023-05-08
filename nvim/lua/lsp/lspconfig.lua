local nvim_lsp = require("lspconfig")

local servers = {
  "bashls",
  "rust_analyzer",
  "clangd",
  "csharp_ls",
  "gopls",
  "jdtls",
  "ruby_ls",
  "lua_ls",
  "elixirls",
  "pyright",
  "solidity",
  "clojure_lsp",
  "tsserver",
  "eslint",
  "astro",
  "angularls",
  "svelte",
  "volar",
  "emmet_ls",
  "html",
  "cssls",
  "cssmodules_ls",
  "tailwindcss",
  "jsonls",
  "graphql",
  "sqlls",
  "prismals",
  "dockerls",
  "marksman",
  "taplo",
  "terraformls",
  "diagnosticls",
}

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = false,
})

-- use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local flags = {
  debounce_text_changes = 100,
}

-- set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, server in ipairs(servers) do
  nvim_lsp[server].setup({
    on_attach,
    flags,
    capabilities,
  })
end

nvim_lsp["lua_ls"].setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "require", "xdg_open" },
      },
    },
  },
})
