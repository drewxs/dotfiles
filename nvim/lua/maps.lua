local map = function(mode, lhs, rhs, opts)
  opts = opts or { silent = true, nowait = true }
  for k, v in pairs(opts) do
    opts[k] = v
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

local remap = { remap = true }

-- navigate windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- resize windows
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

-- split windows
map("n", "ss", ":split<Return><C-w>w")
map("n", "sv", ":vsplit<Return><C-w>w")

-- select
map("n", "<C-a>", "gg<S-v>G")

-- delete
map("i", "<C-h>", "<C-w>")
map("i", "<C-Del>", "<Esc>ldwi")

map("n", "r", "<C-r>")

-- move
map("i", "<A-k>", "<Up>") -- cursor movement
map("i", "<A-j>", "<Down>")
map("i", "<A-h>", "<Left>")
map("i", "<A-l>", "<Right>")
map({ "n", "v" }, "<A-h>", "b") -- word movement
map({ "n", "v" }, "<A-l>", "e")
map("n", "<C-u>", "<C-u>zz") -- center jumps
map("n", "<C-d>", "<C-d>zz")
map("n", "n", "nzzzv") -- center search jumps
map("n", "N", "Nzzzv")
map("i", "<A-a>", "<Esc><S-a>") -- line end
map("i", "<A-;>", "<Esc><S-a>;<CR>") -- line end -> ';' -> new line
map("i", "<A-,>", "<Esc><S-a>,<CR>") -- line end -> ',' -> new line
map("n", "<A-u>", "gg0i<CR><Esc>k") -- new line at beginning of file
map("i", "<A-u>", "<Esc>gg0i<CR><Esc>ki")

-- delete current buffer
map("n", "<A-w>", ":Bdelete!<CR>")
map("i", "<A-w>", "<Esc>:Bdelete!<CR>")

-- save
map("n", "<A-s>", ":lua vim.lsp.buf.format()<CR>:w!<CR>")
map("i", "<A-s>", "<Esc>:lua vim.lsp.buf.format()<CR>:w!<CR>")

-- quit
map("n", "<C-q>", ":qa!<CR>")
map("n", "<A-q>", ":q!<CR>")

-- move text up/down
map("n", "<A-j>", ":m .+1<CR>")
map("n", "<A-k>", ":m .-2<CR>")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- next line
map("i", "<C-o>", "<Esc>o")

-- duplicate
map("n", "<S-j>", "mayyp`aj")
map("v", "<S-j>", "y'>p") -- multiline

-- comment
map("n", "<C-_>", "gcc", remap)
map("i", "<C-_>", "<Esc>gcca", remap)
map("v", "<C-_>", "gb", remap)

-- toggle fold
map("n", "<A-\\>", "za", remap)

-- markdown preview
map("n", "<C-m>", ":MarkdownPreviewToggle<CR>")

-- color picker
map("n", "<A-c>", "<cmd>PickColor<cr>")
map("i", "<A-c>", "<cmd>PickColorInsert<cr>")

-- remove search highlights
map("n", "<Esc>", ":noh<CR>")

-- lsp
map("n", "<A-r>", ":LspRestart<CR>")
map("n", "<S-d>", ":Lspsaga hover_doc<CR>")
map("n", "<S-f>", ":Lspsaga lsp_finder<CR>")
map("n", "<S-r>", ":Lspsaga rename<CR>")
map("n", "<S-t>", ":Lspsaga type<CR>")
map("n", "<S-o>", ":Lspsaga outline<CR>")
map("n", "<S-p>", ":Lspsaga peek_definition<CR>")
map("n", "<A-[>", ":Lspsaga diagnostic_jump_prev<CR>", remap)
map("n", "<A-]>", ":Lspsaga diagnostic_jump_next<CR>", remap)
map("n", "<S-q>", vim.diagnostic.setloclist)
