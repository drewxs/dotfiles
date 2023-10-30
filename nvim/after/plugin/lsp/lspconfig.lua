local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")

mason.setup({
  -- Where Mason should put its bin location in your PATH. Can be one of:
  -- - "prepend" (default, Mason's bin location is put first in PATH)
  -- - "append" (Mason's bin location is put at the end of PATH)
  -- - "skip" (doesn't modify PATH)
  ---@type '"prepend"' | '"append"' | '"skip"'
  PATH = "prepend",
  pip = {
    upgrade_pip = true,
    install_args = {},
  },
  -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
  -- debugging issues with package installations.
  log_level = vim.log.levels.INFO,
  -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
  -- packages that are requested to be installed will be put in a queue.
  max_concurrent_installers = 4,
  github = {
    -- The template URL to use when downloading assets from GitHub.
    -- The placeholders are the following (in order):
    -- 1. The repository (e.g. "rust-lang/rust-analyzer")
    -- 2. The release version (e.g. "v0.3.0")
    -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
    download_url_template = "https://github.com/%s/releases/download/%s/%s",
  },
  -- The provider implementations to use for resolving package metadata (latest version, available versions, etc.).
  -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
  -- Builtin providers are:
  --   - mason.providers.registry-api (default) - uses the https://api.mason-registry.dev API
  --   - mason.providers.client                 - uses only client-side tooling to resolve metadata
  providers = {
    "mason.providers.registry-api",
  },
  ui = {
    check_outdated_packages_on_open = true,
    border = "none",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
    keymaps = {
      toggle_package_expand = "<CR>",
      install_package = "i",
      update_package = "u",
      check_package_version = "c",
      update_all_packages = "U",
      check_outdated_packages = "C",
      uninstall_package = "X",
      cancel_installation = "<C-c>",
      apply_language_filter = "<C-f>",
    },
  },
})

local servers = {
  "bashls",
  "rust_analyzer",
  "clangd",
  "csharp_ls",
  "gopls",
  "jdtls",
  "lua_ls",
  "elixirls",
  "pyright",
  "solidity",
  "tsserver",
  "eslint",
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
}

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
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

local filetypes = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
  "vue",
  "svelte",
  "astro",
}
vim.cmd([[
  augroup EslintAutoFix
  autocmd!
  augroup END
]])
for _, ft in ipairs(filetypes) do
  vim.cmd(
    string.format(
      [[autocmd EslintAutoFix FileType %s nnoremap <buffer> <C-s> :lua vim.cmd("EslintFixAll") vim.lsp.buf.format()<CR>:w!<CR>]],
      ft
    )
  )
  vim.cmd(
    string.format(
      [[autocmd EslintAutoFix FileType %s inoremap <buffer> <C-s> <Esc>:lua vim.cmd("EslintFixAll") vim.lsp.buf.format()<CR>:w!<CR>]],
      ft
    )
  )
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
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
})
