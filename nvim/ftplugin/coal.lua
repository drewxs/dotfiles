-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.coal",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd("%!coal fmt")
    vim.fn.winrestview(view)
  end,
})
