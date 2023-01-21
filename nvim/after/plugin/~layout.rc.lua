vim.cmd([[autocmd VimEnter * call timer_start(0, { tid -> execute('ToggleTerm') })]])
vim.cmd([[autocmd VimEnter * call timer_start(50, { tid -> execute('NvimTreeToggle') })]])
