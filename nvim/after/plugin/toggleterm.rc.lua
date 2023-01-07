require("toggleterm").setup({
  size = 12,
  open_mapping = [[<c-\>]],
  -- shade_filetypes = {},
  shade_terminals = false,
  -- shading_factor = "1",
  start_in_insert = true,
  persist_size = true,
  direction = "horizontal",
  autochdir = true,
  highlights = {
    -- highlights which map to a highlight group name and a table of it's values
    -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
    -- Normal = {
    -- 	guibg = "#000000",
    -- },
    -- NormalFloat = {
    -- 	guibg = "#000000",
    -- },
    -- FloatBorder = {
    -- 	guifg = "#000000",
    -- 	guibg = "#000000",
    -- },
  },
  auto_scroll = true,
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = "curved",
    -- like `size`, width and height can be a number or function which is passed the current terminal
    winblend = 20,
  },
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd([[autocmd! TermOpen term://* lua set_terminal_keymaps()]])

-- set layout
vim.cmd([[ToggleTerm]])
vim.cmd([[NvimTreeToggle]])
vim.cmd([[stopinsert]])
