local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

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
    formatting.autopep8,
    formatting.prettierd,
    formatting.rustfmt,
    formatting.shfmt,
    formatting.stylua,
    formatting.sqlformatter,
  },
})
