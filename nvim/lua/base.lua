-- theme
vim.cmd([[colorscheme ash]])

vim.api.nvim_set_hl(0, "StatusLine", { fg = "#000000", bg = "#000000" })

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- open tree on start
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    require("nvim-tree.api").tree.open()
    vim.cmd("wincmd l")
  end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- auto refresh on focus
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- resize splits on window resize
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- disable diagnostics in env files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".env",
  group = augroup("__env"),
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})

-- auto lint
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- limit notifications
local blacklist = { "No information available" }
vim.notify = function(msg)
  for _, banned in ipairs(blacklist) do
    if msg == banned then
      return
    end
  end
end

-- refresh visible buffers (i.e. splits)
vim.fn.timer_start(3000, function()
  for win = 1, vim.fn.winnr("$") do
    local buf = vim.fn.winbufnr(win)
    if vim.fn.bufloaded(buf) == 1 then
      vim.fn.bufload(buf)
      vim.cmd("checktime " .. buf)
    end
  end
end, { ["repeat"] = -1 })

vim.filetype.add({
  extension = {
    ash = "ash",
    coal = "coal",
  },
})
