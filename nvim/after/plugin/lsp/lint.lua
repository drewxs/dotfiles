require("lint").linters_by_ft = {
  cpp = { "clangtidy" },
  elixir = { "credo" },
  python = { "ruff" },
  lua = { "luacheck" },
  ruby = { "ruby" },
  prisma = { "prisma-lint" },
  proto = { "buf_lint" },
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  zsh = { "zsh" },
}
