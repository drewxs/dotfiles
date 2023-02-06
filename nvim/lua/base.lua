vim.cmd([[autocmd!]])

-- theme
vim.cmd([[colorscheme catppuccin-mocha]])

-- nvim-tree highlights
vim.cmd([[highlight NvimTreeFolderIcon guifg=#555878]])
vim.cmd([[highlight NvimTreeFolderName guifg=#555878]])
vim.cmd([[highlight NvimTreeEmptyFolderIcon guifg=#555878]])
vim.cmd([[highlight NvimTreeEmptyFolderName guifg=#555878]])
vim.cmd([[highlight NvimTreeOpenedFolderIcon guifg=#008484]])
vim.cmd([[highlight NvimTreeOpenedFolderName guifg=#008484]])

-- undercurl
vim.cmd([[let &t_Cs = '\e[4:3m']])
vim.cmd([[let &t_Ce = '\e[4:0m']])

-- highlight yanked text
vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]])

-- turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- auto refresh buffers on change
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
