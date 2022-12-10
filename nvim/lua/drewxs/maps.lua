local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true, nowait = true }
local remap = { noremap = false, silent = true, nowait = true }

-- navigate windows
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- resize windows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- split windows
map("n", "ss", ":split<Return><C-w>w", opts)
map("n", "sv", ":vsplit<Return><C-w>w", opts)

-- nvim-tree
map("n", "<C-e>", ":NvimTreeToggle<CR>", opts)

-- copy
map("v", "c", "y", opts)
map("n", "cc", "yy", opts)

-- delete word <--
map("i", "<C-H>", "<C-w>", opts)
-- delete word -->
map("i", "<C-Del>", "<Esc><Right>dwi", opts)

-- movement
map("i", "<A-k>", "<Up>", opts)
map("i", "<A-j>", "<Down>", opts)
map("i", "<A-h>", "<Left>", opts)
map("i", "<A-l>", "<Right>", opts)
map("n", "<A-h>", "b", opts)
map("v", "<A-h>", "b", opts)
map("n", "<A-l>", "w", opts)
map("v", "<A-l>", "w", opts)

-- select all
map("n", "<C-a>", "gg<S-v>G", opts)

-- new tab
map("n", "<C-n>", ":tabedit<CR>", opts)

-- delete current buffer
map("n", "<A-w>", ":Bdelete!<CR>", opts)
map("i", "<A-w>", "<Esc>:Bdelete!<CR>", opts)

-- save
map("n", "<A-s>", ":lua vim.lsp.buf.format()<CR>:w!<CR>", opts)
map("i", "<A-s>", "<Esc>:lua vim.lsp.buf.format()<CR>:w!<CR>", opts)

-- quit
map("n", "<C-q>", ":q!<CR>", opts)
map("i", "<C-q>", "<Esc>:q!<CR>", opts)

-- move text up/down
map("n", "<A-j>", ":m .+1<CR>", opts)
map("n", "<A-k>", ":m .-2<CR>", opts)

-- next line
map("i", "<C-o>", "<Esc>o", opts)

-- duplicate current line
map("n", "<S-j>", "mayyp`aj", opts)

-- comment
map("n", "<C-_>", "gcc", remap)
map("i", "<C-_>", "<ESC>gcca", remap)
map("v", "<C-_>", "gc", remap)

-- toggle fold
map("n", "<A-\\>", "za", remap)

-- lspsaga
map("n", "<C-j>", ":Lspsaga hover_doc<CR>", opts)
map("n", "<C-k>", ":Lspsaga lsp_finder<CR>", opts)
map("n", "<S-r>", ":Lspsaga rename<CR>", opts)

-- diagnostics
vim.keymap.set("n", "<C-;>", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<C-[>", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<C-]>", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<S-q>", vim.diagnostic.setloclist, opts)
