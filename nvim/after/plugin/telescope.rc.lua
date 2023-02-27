local status, telescope = pcall(require, "telescope")
if not status then
  return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand("%:p:h")
end

local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd("startinsert")
          end,
        },
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
})

telescope.load_extension("file_browser")

-- keymaps
vim.keymap.set("n", "<C-p>", function()
  builtin.find_files()
end)
vim.keymap.set("n", "<C-f>", function()
  builtin.live_grep()
end)
vim.keymap.set("n", "sf", function()
  builtin.live_grep({ search_dirs = { vim.fn.expand("%:p") } })
end)
vim.keymap.set("n", "sb", function()
  builtin.buffers()
end)
vim.keymap.set("n", "st", function()
  builtin.help_tags()
end)
vim.keymap.set("n", "sr", function()
  builtin.resume()
end)
vim.keymap.set("n", "sd", function()
  builtin.diagnostics()
end)
vim.keymap.set("n", "se", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 },
  })
end)
