local default_opts = { silent = true, nowait = true }
local remap = { remap = true }

local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  setmetatable(opts, { __index = default_opts })
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- GENERAL
map("n", "<esc>", "<cmd>noh<cr>") -- clear highlights
map("n", "<c-a>", "gg<s-v>G") -- select all
map("n", "r", "<c-r>") -- redo
map("n", "<a-\\>", "za", remap) -- toggle fold
map("n", "<c-_>", "gcc", remap) -- toggle comment
map("i", "<c-_>", "<esc>gcca", remap) -- toggle comment
map("v", "<c-_>", "gb", remap) -- toggle selection

-- NORMALIZE
map("n", "<c-u>", "<c-u>zz") -- center jump up
map("n", "<c-d>", "<c-d>zz") -- center jump down
map("n", "N", "Nzzzv") -- center search jump up
map("n", "n", "nzzzv") -- center search jump down

-- WINDOW MANAGEMENT
map("n", "<c-h>", "<c-w>h") -- window left
map("n", "<c-j>", "<c-w>j") -- window down
map("n", "<c-k>", "<c-w>k") -- window up
map("n", "<c-l>", "<c-w>l") -- window right
map("n", "<c-left>", "<cmd>vertical resize +2<cr>") -- increase width
map("n", "<c-right>", "<cmd>vertical resize -2<cr>") -- decrease width
map("n", "zx", "<cmd>split<return><c-w>w") -- split horizontally
map("n", "zc", "<cmd>vsplit<return><c-w>w") -- split vertically

-- BUFFER MANAGEMENT
map("n", "<s-l>", "<cmd>bnext<cr>") -- next buffer
map("n", "<s-h>", "<cmd>bprevious<cr>") -- previous buffer
map({ "n", "i" }, "<c-s>", function()
  vim.cmd.write()
end) -- save buffer (no format)
map({ "n", "i" }, "<a-s>", function()
  vim.lsp.buf.format()
  vim.cmd.write()
  vim.cmd.stopinsert()
end) -- save and format buffer
map("n", "<a-w>", "<cmd>Bdelete!<cr>") -- delete buffer
map("n", "<c-q>", "<cmd>qa!<cr>") -- quit all
map("n", "<a-q>", "<cmd>q!<cr>") -- quit buffer

-- MOVEMENT
-- insert-mode cursor movement
map("i", "<a-k>", "<up>") -- up
map("i", "<a-j>", "<down>") -- down
-- word movement
map({ "n", "v" }, "<a-h>", "b") -- beginning of word
map({ "n", "v" }, "<a-l>", "e") -- end of word
-- line movement
map("i", "<c-b>", "<esc><s-i>") -- beginning of line
map("i", "<c-e>", "<end>") -- end of line
map("i", "<a-;>", "<esc><s-a>;<cr>") -- line end -> ';' -> new line
map("i", "<a-,>", "<esc><s-a>,<cr>") -- line end -> ',' -> new line
map("n", "<a-u>", "gg0i<cr><esc>k") -- new line at beginning of file
map("i", "<a-u>", "<esc>gg0i<cr><esc>ki") -- new line at beginning of file
map("i", "<c-o>", "<esc>o") -- new line below

-- TEXT MANIPULATION
-- words
map("i", "<a-l>", "<del>") -- delete previous char
map("i", "<a-h>", "<bs>") -- delete next char
map("i", "<c-h>", "<c-w>") -- delete previous word
map("i", "<c-l>", "<esc>ldwi") -- delete next word
-- lines
map("n", "<a-j>", ":m .+1<cr>") -- move line down
map("n", "<a-k>", ":m .-2<cr>") -- move line up
map("v", "<a-j>", ":m '>+1<cr>gv=gv") -- move selection down
map("v", "<a-k>", ":m '<-2<cr>gv=gv") -- move selection up
-- duplication
map("n", "<s-j>", "mayyp`aj") -- duplicate line
map("v", "<s-j>", "y'>p") -- duplicate selection

-- MISC
map("n", "<a-c>", "<cmd>PickColor<cr>") -- color picker
map("i", "<a-c>", "<cmd>PickColorInsert<cr>") -- color picker
map("n", "<s-m>", "<cmd>MarkdownPreviewToggle<cr>") -- markdown preview

-- LSP
map("n", "<a-r>", "<cmd>LspRestart<cr>")
map("n", "<s-d>", "<cmd>Lspsaga hover_doc<cr>")
map("n", "<s-f>", "<cmd>Lspsaga lsp_finder<cr>")
map("n", "<s-r>", "<cmd>Lspsaga rename<cr>")
map("n", "<s-t>", "<cmd>Lspsaga type<cr>")
map("n", "<s-o>", "<cmd>Lspsaga outline<cr>")
map("n", "<s-p>", "<cmd>Lspsaga peek_definition<cr>")
map("n", "<a-[>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", remap)
map("n", "<a-]>", "<cmd>Lspsaga diagnostic_jump_next<cr>", remap)
map("n", "<s-q>", vim.diagnostic.setloclist)
