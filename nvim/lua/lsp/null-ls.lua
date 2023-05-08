local null_ls = require("null-ls")

local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    code_actions.eslint_d,
    code_actions.shellcheck,
    diagnostics.buf,
    diagnostics.eslint_d,
    diagnostics.shellcheck,
    diagnostics.credo,
    formatting.autopep8,
    formatting.prettierd,
    formatting.rustfmt,
    formatting.shfmt,
    formatting.stylua,
    formatting.sql_formatter,
    formatting.mix,
  },
})
