vim.cmd("autocmd!")

-- theme
vim.cmd([[colorscheme catppuccin-mocha]])

-- undercurl
vim.cmd([[let &t_Cs = '\e[4:3m']])
vim.cmd([[let &t_Ce = '\e[4:0m']])

-- turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- add asterisks in block comments
vim.opt.formatoptions:append({ "r" })
