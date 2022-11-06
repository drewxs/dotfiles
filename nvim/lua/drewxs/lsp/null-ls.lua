local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.code_actions.eslint_d,
		-- null_ls.builtins.code_actions.ltrs,
		null_ls.builtins.diagnostics.commitlint,
		null_ls.builtins.diagnostics.cppcheck,
	},
})
