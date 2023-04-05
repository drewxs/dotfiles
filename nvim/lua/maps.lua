local map = vim.keymap.set
local opts = { silent = true, nowait = true }
local remap = { silent = true, nowait = true, remap = true }

-- navigate windows
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- resize windows
map("n", "<C-Left>", ":vertical resize +2<CR>", opts)
map("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- split windows
map("n", "ss", ":split<Return><C-w>w", opts)
map("n", "sv", ":vsplit<Return><C-w>w", opts)

-- nvim-tree
map("n", "<C-e>", ":NvimTreeToggle<CR>", opts)

-- copy
map("v", "c", "y", opts)
map("n", "cc", "yy", opts)
map("n", "cw", "yiw", opts)

-- select
map("n", "<C-a>", "gg<S-v>G", opts)

-- delete
map("i", "<C-h>", "<C-w>", opts)
map("i", "<C-Del>", "<Esc>ldwi", opts)

-- move
map("i", "<A-k>", "<Up>", opts) -- cursor movement
map("i", "<A-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)
map("i", "<C-j>", "<Down>", opts)
map("n", "<A-h>", "b", opts) -- word movement
map("n", "<A-l>", "e", opts)
map("v", "<A-h>", "b", opts)
map("v", "<A-l>", "e", opts)
map("i", "<A-h>", "<S-Left>", opts)
map("i", "<A-l>", "<S-Right>", opts)
map("n", "<C-u>", "<C-u>zz", opts) -- center jumps
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "n", "nzzzv", opts) -- center search jumps
map("n", "N", "Nzzzv", opts)
map("i", "<A-a>", "<Esc><S-a>", opts) -- line end
map("i", "<A-;>", "<Esc><S-a>;<CR>", opts) -- line end -> ';' -> new line
map("i", "<A-,>", "<Esc><S-a>,<CR>", opts) -- line end -> ',' -> new line
map("n", "<A-u>", "gg0i<CR><Esc>k", opts) -- new line at beginning of file
map("i", "<A-u>", "<Esc>gg0i<CR><Esc>ki", opts)

-- delete current buffer
map("n", "<A-w>", ":Bdelete!<CR>", opts)
map("i", "<A-w>", "<Esc>:Bdelete!<CR>", opts)

-- save
map("n", "<A-s>", ":lua vim.lsp.buf.format()<CR>:w!<CR>", opts)
map("i", "<A-s>", "<Esc>:lua vim.lsp.buf.format()<CR>:w!<CR>", opts)

-- quit
map("n", "<C-q>", ":qa!<CR>", opts)
map("n", "<A-q>", ":q!<CR>", opts)

-- move text up/down
map("n", "<A-j>", ":m .+1<CR>", opts)
map("n", "<A-k>", ":m .-2<CR>", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- next line
map("i", "<C-o>", "<Esc>o", opts)

-- duplicate
map("n", "<S-j>", "mayyp`aj", opts)
map("v", "<S-j>", "y'>p", opts) -- multiline

-- comment
map("n", "<C-_>", "gcc", remap)
map("i", "<C-_>", "<Esc>gcca", remap)
map("v", "<C-_>", "gb", remap)

-- toggle fold
map("n", "<A-\\>", "za", remap)

-- markdown preview
map("n", "<C-M>", ":MarkdownPreviewToggle<CR>", opts)

-- color picker
map("n", "<C-c>", "<cmd>PickColor<cr>", opts)
map("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

-- remove search highlights
map("n", "<Esc>", ":noh<CR>", opts)

-- lsp
map("n", "<A-r>", ":LspRestart<CR>", opts)
map("n", "<S-d>", ":Lspsaga hover_doc<CR>", opts)
map("n", "<S-f>", ":Lspsaga lsp_finder<CR>", opts)
map("n", "<S-r>", ":Lspsaga rename<CR>", opts)
map("n", "<S-o>", ":LSoutlineToggle<CR>", opts)
map("n", "<S-p>", ":Lspsaga peek_definition<CR>", opts)
map("n", "<A-[>", ":Lspsaga diagnostic_jump_prev<CR>", remap)
map("n", "<A-]>", ":Lspsaga diagnostic_jump_next<CR>", remap)
map("n", "<S-q>", vim.diagnostic.setloclist, opts)
