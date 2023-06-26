vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
end

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
  git = {
    enable = false,
    ignore = true,
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
    indent_markers = {
      enable = true,
    },
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = true,
      },
    },
  },
  view = {
    adaptive_size = true,
    hide_root_folder = true,
    width = 35,
  },
  on_attach = on_attach,
})