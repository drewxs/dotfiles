local opt = vim.opt
local g = vim.g

g.mapleader = " "

-- encodinng
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- general
opt.shell = "zsh"
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.backspace = { "start", "eol", "indent" }
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.inccommand = "split"
opt.wildoptions = "pum"
opt.swapfile = false
opt.formatoptions = "tcqjr"

-- indentation
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.expandtab = true
opt.smarttab = true
opt.shiftround = true
opt.tabstop = 2
opt.shiftwidth = 2

-- search
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true

-- interface
opt.title = true
opt.laststatus = 2
opt.showcmd = true
opt.showmode = false
opt.cmdheight = 1
opt.backup = false
opt.scrolloff = 12
opt.wrap = false
opt.ruler = false
opt.number = true
opt.numberwidth = 4
opt.background = "dark"
opt.whichwrap = "lh"
opt.signcolumn = "number"
opt.cursorline = true
opt.termguicolors = true
opt.winblend = 0
opt.pumblend = 5
opt.timeoutlen = 100

-- paths
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })

-- folds
opt.foldmethod = "expr"
opt.foldlevel = 99
opt.foldexpr = "nvim_treesitter#foldexpr()"
