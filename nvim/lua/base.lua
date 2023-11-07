-- theme
vim.cmd([[colorscheme catppuccin]])

-- undercurl
vim.cmd([[let &t_Cs = '\e[4:3m']])
vim.cmd([[let &t_Ce = '\e[4:0m']])

-- highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- open tree on start
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    require("nvim-tree.api").tree.open()
  end,
})

-- auto refresh buffers on change
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- turn off paste mode when leaving insert
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = "*",
  command = "set nopaste",
})
