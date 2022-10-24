local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local remap = { noremap = false, silent = true }

-------------
-- general --
-------------

-- navigate windows
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- navigate buffers
map('n', '<S-l>', ':bnext<CR>', opts)
map('n', '<S-h>', ':bprevious<CR>', opts)

-- resize windows
map('n', '<C-Up>', ':resize -2<CR>', opts)
map('n', '<C-Down>', ':resize +2<CR>', opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- split windows
map('n', 'ss', ':split<Return><C-w>w', opts)
map('n', 'sv', ':vsplit<Return><C-w>w', opts)

-- delete word <--
map('i', '<C-H>', '<C-w>', opts)
-- delete word -->
map('i', '<C-Del>', '<Esc><Right>dwi', opts)

-- move back one word
map('i', '<A-h>', '<C-Left>', opts)
-- move forward one word
map('i', '<A-l>', '<C-Right>', opts)

-- select all
map('n', '<C-a>', 'gg<S-v>G', opts)

-- new tab
map('n', '<C-n>', ':tabedit<CR>', opts)

-- save
map('n', '<C-s>', ':Prettier<CR>:w!<CR>', opts)
map('i', '<C-s>', '<Esc>:Prettier<CR>:w!<CR>', opts)

-- quit
map('n', '<C-q>', ':q!<CR>', opts)
map('i', '<C-q>', '<Esc>:q!<CR>', opts)

-- toggle explorer
map('n', '<C-e>', ':NvimTreeToggle<CR>', opts)

-- move text up/down
map('n', '<A-j>', ':m .+1<CR>', opts)
map('n', '<A-k>', ':m .-2<CR>', opts)

-- next line
map('i', '<C-o>', '<Esc>o', opts)

-- comment
map('n', '<C-_>', 'gcc', remap)
map('i', '<C-_>', '<ESC>gcc', remap)
map('v', '<C-_>', 'gb', remap)


------------
-- leader --
------------

map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '

-- nvim-tree
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

-- telescope
map('n', '<C-p>', ':Telescope find_files<CR>', opts)
map('n', '<C-f>', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fp', ':Telescope projects<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)


---------
-- LSP --
---------

-- lspsaga
map('n', '<C-j>', ':Lspsaga diagnostic_jump_next<CR>', opts)
map('n', '<S-j>', ':Lspsaga hover_doc<CR>', opts)
map('n', '<C-k>', ':Lspsaga lsp_finder<CR>', opts)
map('i', '<S-k>', ':Lspsaga signature_help<CR>', opts)
map('n', 'gp', ':Lspsaga peek_definition<CR>', opts)
map('n', 'gr', ':Lspsaga rename<CR>', opts)

-- diagnostics
vim.keymap.set('n', '<C-;>', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<C-[>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-]>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
