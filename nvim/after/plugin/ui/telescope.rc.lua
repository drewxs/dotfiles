local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
      },
      n = {
        ["q"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
})

-- keymaps
vim.keymap.set("n", "<c-p>", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd("startinsert")
  else
    builtin.find_files()
  end
end)
vim.keymap.set("n", "<c-f>", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd("startinsert")
  else
    builtin.live_grep()
  end
end)
vim.keymap.set("n", "<c-e>", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd("startinsert")
  else
    builtin.live_grep({ search_dirs = { vim.fn.expand("%:p") } })
  end
end)
vim.keymap.set("n", "<c-b>", function()
  builtin.buffers()
end)
vim.keymap.set("n", "<c-t>", function()
  builtin.help_tags()
end)
vim.keymap.set("n", "<c-r>", function()
  builtin.resume()
end)
vim.keymap.set("n", "<c-o>", function()
  builtin.diagnostics()
end)
