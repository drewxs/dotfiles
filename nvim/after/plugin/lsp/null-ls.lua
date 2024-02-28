local nls = require("null-ls")

nls.setup({
  sources = {
    nls.builtins.diagnostics.zsh,
    nls.builtins.diagnostics.shellcheck,
    nls.builtins.diagnostics.buf,
    nls.builtins.diagnostics.clang_check,
    nls.builtins.diagnostics.ruff,
    nls.builtins.diagnostics.credo,
    nls.builtins.diagnostics.luacheck,
    nls.builtins.diagnostics.eslint_d,
    nls.builtins.diagnostics.rubocop,

    nls.builtins.formatting.shfmt,
    nls.builtins.formatting.buf,
    nls.builtins.formatting.rustfmt,
    nls.builtins.formatting.leptosfmt,
    nls.builtins.formatting.clang_format,
    nls.builtins.formatting.gofmt,
    nls.builtins.formatting.ruff_format,
    nls.builtins.formatting.mix,
    nls.builtins.formatting.stylua,
    nls.builtins.formatting.prettierd,
    nls.builtins.formatting.rubyfmt,
    nls.builtins.formatting.sql_formatter,
  },
})
