local opt = vim.opt
local o = vim.o
local g = vim.g

g.mapleader = " "
o.autoread = true

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
opt.updatetime = 100

-- indentation
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.expandtab = true
opt.smarttab = true
opt.shiftround = true
opt.tabstop = 2
opt.softtabstop = 2
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
opt.scrolloff = 50
opt.wrap = false
opt.ruler = false
opt.number = true
opt.background = "dark"
opt.whichwrap = "lh"
opt.signcolumn = "yes:1"
opt.cursorline = true
opt.termguicolors = true
opt.winblend = 0
opt.pumblend = 5
opt.timeout = true
opt.timeoutlen = 50

-- paths
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })

-- folds
opt.foldmethod = "expr"
opt.foldlevel = 99
opt.foldexpr = "nvim_treesitter#foldexpr()"
