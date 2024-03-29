require("conform").setup({
  formatters_by_ft = {
    sh = { "shfmt" },
    rust = { "rustfmt" },
    elixir = { "mix" },
    go = { "gofmt" },
    python = { "ruff_format" },
    lua = { "stylua" },
    ruby = { "rubyfmt" },
    typescriptreact = { { "prettierd", "prettier" } },
    javascriptreact = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    javascript = { { "prettierd", "prettier" } },
    scss = { { "prettierd", "prettier" } },
    css = { { "prettierd", "prettier" } },
    sql = { "sqlfluff" },
    proto = { "buf" },
    markdown = { { "prettierd", "prettier" } },
    json = { { "prettierd", "prettier" } },
    toml = { "taplo" },
    yaml = { "yg" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
