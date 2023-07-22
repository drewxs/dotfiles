local map = function(mode, lhs, rhs, opts)
  opts = opts or { silent = true, nowait = true }
  for k, v in pairs(opts) do
    opts[k] = v
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

local remap = { remap = true }

-- GENERAL
map("n", "<Esc>", ":noh<CR>") -- clear highlights
map("n", "<C-a>", "gg<S-v>G") -- select all
map("n", "r", "<C-r>") -- redo
map("n", "<A-\\>", "za", remap) -- toggle fold
map("n", "<C-_>", "gcc", remap) -- toggle comment
map("i", "<C-_>", "<Esc>gcca", remap) -- toggle comment
map("v", "<C-_>", "gb", remap) -- toggle selection

-- NORMALIZE
map("n", "<C-u>", "<C-u>zz") -- center jump up
map("n", "<C-d>", "<C-d>zz") -- center jump down
map("n", "N", "Nzzzv") -- center search jump up
map("n", "n", "nzzzv") -- center search jump down

-- WINDOW MANAGEMENT
map("n", "<C-h>", "<C-w>h") -- window left
map("n", "<C-j>", "<C-w>j") -- window down
map("n", "<C-k>", "<C-w>k") -- window up
map("n", "<C-l>", "<C-w>l") -- window right
map("n", "<C-Left>", ":vertical resize +2<CR>") -- increase width
map("n", "<C-Right>", ":vertical resize -2<CR>") -- decrease width
map("n", "ss", ":split<Return><C-w>w") -- split horizontally
map("n", "sv", ":vsplit<Return><C-w>w") -- split vertically

-- BUFFER MANAGEMENT
map("n", "<S-l>", ":bnext<CR>") -- next buffer
map("n", "<S-h>", ":bprevious<CR>") -- previous buffer
map({ "n", "i" }, "<C-s>", "<Esc>:w!<CR>") -- save buffer (no format)
map({ "n", "i" }, "<A-s>", "<Esc>:lua vim.lsp.buf.format()<CR>:w!<CR>") -- save and format buffer
map({ "n", "i" }, "<A-w>", "<Esc>:Bdelete!<CR>") -- delete buffer
map("n", "<C-q>", ":qa!<CR>") -- quit all
map("n", "<A-q>", ":q!<CR>") -- quit buffer

-- MOVEMENT
-- insert-mode cursor movement
map("i", "<A-k>", "<Up>") -- up
map("i", "<A-j>", "<Down>") -- down
map("i", "<A-h>", "<Left>") -- left
map("i", "<A-l>", "<Right>") -- right
-- word movement
map({ "n", "v" }, "<A-h>", "b") -- beginning of word
map({ "n", "v" }, "<A-l>", "e") -- end of word
-- line movement
map("i", "<C-b>", "<Esc><S-i>") -- beginning of line
map("i", "<C-e>", "<End>") -- end of line
map("i", "<A-;>", "<Esc><S-a>;<CR>") -- line end -> ';' -> new line
map("i", "<A-,>", "<Esc><S-a>,<CR>") -- line end -> ',' -> new line
map("n", "<A-u>", "gg0i<CR><Esc>k") -- new line at beginning of file
map("i", "<A-u>", "<Esc>gg0i<CR><Esc>ki") -- new line at beginning of file
map("i", "<C-o>", "<Esc>o") -- new line below

-- TEXT MANIPULATION
-- words
map("i", "<C-h>", "<C-w>") -- delete previous word
map("i", "<C-Del>", "<Esc>ldwi") -- delete next word
-- lines
map("n", "<A-j>", ":m .+1<CR>") -- move line down
map("n", "<A-k>", ":m .-2<CR>") -- move line up
map("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move selection down
map("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move selection up
-- duplication
map("n", "<S-j>", "mayyp`aj") -- duplicate line
map("v", "<S-j>", "y'>p") -- duplicate selection

-- MISC
map("n", "<A-c>", "<cmd>PickColor<cr>") -- color picker
map("i", "<A-c>", "<cmd>PickColorInsert<cr>") -- color picker
map("n", "<S-m>", ":MarkdownPreviewToggle<CR>") -- markdown preview

-- LSP
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
