local nls = require("null-ls")

nls.setup({
  sources = {
    nls.builtins.formatting.black,
    nls.builtins.formatting.prettierd,
    nls.builtins.formatting.rustfmt,
    nls.builtins.formatting.shfmt,
    nls.builtins.formatting.stylua,
    nls.builtins.formatting.sql_formatter,
    nls.builtins.formatting.mix,
  },
})
