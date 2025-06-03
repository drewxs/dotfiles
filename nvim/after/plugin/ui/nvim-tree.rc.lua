vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  filesystem_watchers = {
    enable = true,
  },
  filters = {
    dotfiles = false,
  },
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  renderer = {
    root_folder_label = false,
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = false,
      },
    },
  },
  view = {
    adaptive_size = true,
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  end,
})
