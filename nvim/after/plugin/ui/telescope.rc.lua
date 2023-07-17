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
vim.keymap.set("n", "<C-p>", function()
  builtin.find_files()
end)
vim.keymap.set("n", "<C-f>", function()
  builtin.live_grep()
end)
vim.keymap.set("n", "<C-e>", function()
  builtin.live_grep({ search_dirs = { vim.fn.expand("%:p") } })
end)
vim.keymap.set("n", "<C-b>", function()
  builtin.buffers()
end)
vim.keymap.set("n", "<C-t>", function()
  builtin.help_tags()
end)
vim.keymap.set("n", "<C-r>", function()
  builtin.resume()
end)
vim.keymap.set("n", "<C-o>", function()
  builtin.diagnostics()
end)
