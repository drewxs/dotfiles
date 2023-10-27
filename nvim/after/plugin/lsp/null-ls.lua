local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    formatting.black,
    formatting.prettierd,
    formatting.rustfmt,
    formatting.shfmt,
    formatting.stylua,
    formatting.sql_formatter,
    formatting.mix,
  },
})
