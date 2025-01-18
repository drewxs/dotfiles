local map = require("utils").map

-- GENERAL
map("i", "jj", "<esc>", { desc = "Exit insert/visual mode" })
map("n", "<esc>", "<cmd>noh<cr>", { desc = "Clear highlights" })
map("n", "<c-a>", "gg<s-v>G", { desc = "Select all" })
map("n", "r", "<c-r>", { desc = "Redo" })
map("n", "<a-\\>", "za", { remap = true, desc = "Toggle fold" })
map("n", "<c-_>", "gcc", { remap = true, desc = "Toggle comment" })
map("i", "<c-_>", "<esc>gcca", { remap = true, desc = "Toggle comment" })
map("v", "<c-_>", "gb", { remap = true, desc = "Toggle selection" })
map("n", "qq", 'yi"', { desc = "copy inside quotes" })

-- NORMALIZE
map({ "n", "v" }, "j", "jzz", { desc = "Center up" })
map({ "n", "v" }, "k", "kzz", { desc = "Center down" })
map({ "n", "v" }, "<c-u>", "<c-u>zz", { desc = "Center jump up" })
map({ "n", "v" }, "<c-d>", "<c-d>zz", { desc = "Center jump down" })
map("n", "N", "Nzzzv", { desc = "Center search jump up" })
map("n", "n", "nzzzv", { desc = "Center search jump down" })

-- WINDOW MANAGEMENT
map("n", "<c-h>", "<c-w>h", { desc = "Window left" })
map("n", "<c-j>", "<c-w>j", { desc = "Window down" })
map("n", "<c-k>", "<c-w>k", { desc = "Window up" })
map("n", "<c-l>", "<c-w>l", { desc = "Window right" })
map("n", "<c-left>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })
map("n", "<c-right>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
map("n", "zx", "<cmd>split<return><c-w>w", { desc = "Split horizontally" })
map("n", "zc", "<cmd>vsplit<return><c-w>w", { desc = "Split vertically" })

-- BUFFER MANAGEMENT
map("n", "<s-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<s-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map({ "n", "i" }, "<c-s>", function()
  vim.cmd.write()
end, { desc = "Save buffer" })
map({ "n", "i" }, "<a-s>", function()
  vim.cmd.write()
  vim.cmd.stopinsert()
end, { desc = "Save buffer" })
map("i", "jk", function()
  vim.cmd.stopinsert()
end, { desc = "Exit insert mode" })
map("n", { "<c-w>", "<a-w>", "<s-w>" }, "<cmd>Bdelete!<cr>", { desc = "Delete buffer" })
map("n", "<c-q>", "<cmd>qa!<cr>", { desc = "Quit nvim" })
map("n", "<a-q>", "<cmd>q!<cr>", { desc = "Quit buffer" })

-- MOVEMENT
-- insert-mode cursor movement
map("i", { "<c-k>", "<a-k>" }, "<up>", { desc = "Move up" })
map("i", { "<c-j>", "<a-j>" }, "<down>", { desc = "Move down" })
map("i", "<a-h>", "<left>", { desc = "Move left" })
map("i", "<a-l>", "<right>", { desc = "Move right" })
-- word movement
map({ "n", "v" }, "<a-h>", "b", { desc = "Beginning of word" })
map({ "n", "v" }, "<a-l>", "e", { desc = "End of word" })
-- line movement
map("i", { "<c-b>", "<a-b>" }, "<esc><s-i>", { desc = "Beginning of line" })
map("i", { "<c-e>", "<a-e>" }, "<end>", { desc = "End of line" })
map({ "n", "i" }, "<a-;>", "<esc><s-a>;", { desc = "End of line -> ';'" })
map({ "n", "i" }, "<a-,>", "<esc><s-a>,", { desc = "End of line -> ','" })
map("i", "<a-[>", "<esc><s-a> {}<left>", { desc = "End of line -> '{'" })
map({ "n", "i" }, "<a-u>", "<esc>gg0i<cr><esc>ki", { desc = "New line at beginning of file" })
map({ "n", "i" }, "<a-i>", "<esc><up>o", { desc = "New line at previous line" })
map("i", "<c-o>", "<esc>o", { desc = "New line below" })

-- TEXT MANIPULATION
-- words
map("i", "<c-l>", "<del>", { desc = "Delete previous char" })
map("i", "<c-h>", "<bs>", { desc = "Delete next char" })
-- lines
map("n", "<a-j>", ":m .+1<cr>", { desc = "Move line down" })
map("n", "<a-k>", ":m .-2<cr>", { desc = "Move line up" })
map("v", "<a-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<a-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
map("n", "dh", "d^", { desc = "Delete to start of line" })
map("n", "dl", "d$", { desc = "Delete to end of line" })
-- duplication
map("n", "<s-j>", "mayyp`aj", { desc = "Duplicate line" })
map("v", "<s-j>", "y'>p", { desc = "Duplicate selection" })

-- MISC
map("n", "<a-c>", "<cmd>PickColor<cr>", { desc = "Color picker" })
map("i", "<a-c>", "<cmd>PickColorInsert<cr>", { desc = "Color picker" })

-- LSP
map("n", "<a-r>", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
map("n", "<s-d>", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover doc" })
map("n", "<s-f>", "<cmd>Lspsaga finder<cr>", { desc = "Finder" })
map("n", "<s-r>", "<cmd>Lspsaga rename<cr>", { desc = "Rename" })
map("n", "<s-t>", "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Peek type definition" })
map("n", "<s-o>", "<cmd>Lspsaga outline<cr>", { desc = "Outline" })
map("n", "<s-p>", "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek definition" })
map("n", "<a-[>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { remap = true, desc = "Jump to previous diagnostic" })
map("n", "<a-]>", "<cmd>Lspsaga diagnostic_jump_next<cr>", { remap = true, desc = "Jump to next diagnostic" })
