local lsp_installer_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not lsp_installer_ok then return end
local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then return end

local protocol = require('vim.lsp.protocol')

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local servers = {
  'sumneko_lua',
  'rust_analyzer',
  'eslint',
  'tsserver',
  'pyright',
  'html',
  'cssls',
  'jsonls',
  'yamlls',
  'bashls',
}

lsp_installer.setup({
  ensure_installed = servers,
  automatic_installation = true,
  ui = {
    check_outdated_servers_on_open = true,
  }
})

-- use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local lsp_flags = {
  debounce_text_changes = 150,
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = on_attach,
    flags = lsp_flags,
  })
end

lspconfig.eslint.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    imports = {
      granularity = {
        group = 'module',
      },
      prefix = 'self',
    },
    cargo = {
      buildScripts = {
        enable = true,
      },
    },
    procMacro = {
      enable = true,
    },
  },
})
