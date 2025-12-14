local opt = vim.opt

vim.g.mapleader = " "

-- encoding
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
opt.hidden = true
opt.swapfile = false
opt.formatoptions = "tcqjr"
opt.updatetime = 100
opt.autoread = true
opt.guicursor = {
  "n-v-c:block",
  "i:ver25",
  "r-cr:hor20",
  "o:hor50",
  "a:Cursor/lCursor",
  "sm:block",
}
opt.fillchars = { eob = " " }
opt.scrolloff = 999

-- indentation
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.expandtab = true
opt.smarttab = true
opt.shiftround = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

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
opt.wrap = true
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
opt.timeoutlen = 200

-- paths
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })

-- folds
opt.foldmethod = "expr"
opt.foldlevel = 99
opt.foldexpr = "nvim_treesitter#foldexpr()"
