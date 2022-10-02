local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

---------------------
-- normal mode 'n' --
---------------------

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

-- select all
map('n', '<C-a>', 'gg<S-v>G', opts)

-- new tab
map('n', '<C-n>', ':tabedit<CR>', opts)

-- save
map('n', '<C-s>', ':w<CR>', opts)

-- delete current buffer
map('n', '<C-w>', ':Bdelete!<CR>', opts)

-- quit
map('n', '<C-q>', ':qa!<CR>', opts)

-- toggle explorer
map('n', '<C-b>', ':NvimTreeToggle<CR>', opts)


---------------------
-- insert mode 'i' --
---------------------

-- move text up/down
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)


--------------------
-- leader 'space' --
--------------------

map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '

-- nvim-tree
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

-- telescope
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>ft', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fp', ':Telescope projects<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)

-- git
map('n', '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', opts)

-- comment
map('n', '<leader>/', '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', opts)
map('x', '<leader>/', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', opts)

-- dap
map('n', '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<cr>', opts)
map('n', '<leader>dc', '<cmd>lua require("dap").continue()<cr>', opts)
map('n', '<leader>di', '<cmd>lua require("dap").step_into()<cr>', opts)
map('n', '<leader>do', '<cmd>lua require("dap").step_over()<cr>', opts)
map('n', '<leader>dO', '<cmd>lua require("dap").step_out()<cr>', opts)
map('n', '<leader>dr', '<cmd>lua require("dap").repl.toggle()<cr>', opts)
map('n', '<leader>dl', '<cmd>lua require("dap").run_last()<cr>', opts)
map('n', '<leader>du', '<cmd>lua require("dapui").toggle()<cr>', opts)
map('n', '<leader>dt', '<cmd>lua require("dap").terminate()<cr>', opts)
