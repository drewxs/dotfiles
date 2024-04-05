require("lint").linters_by_ft = {
  cpp = { "clang-tidy" },
  go = { "golangcilint" },
  elixir = { "credo" },
  typescript = { "eslint_d" },
  javascript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  python = { "ruff" },
  ruby = { "ruby" },
  lua = { "luacheck" },
  prisma = { "prisma-lint" },
  proto = { "buf_lint" },
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  zsh = { "zsh" },
}
