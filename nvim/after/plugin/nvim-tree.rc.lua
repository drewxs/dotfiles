local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
	return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
	renderer = {
		indent_markers = {
			enable = true,
		},
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
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
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	filters = {
		dotfiles = false,
	},
	git = {
		enable = true,
		ignore = false,
	},
	update_focused_file = { enable = true },
	hijack_directories = { enable = true },
	open_on_setup = true,
	view = {
		adaptive_size = true,
		hide_root_folder = true,
		width = 35,
		mappings = {
			list = {
				{ key = "l", action = "edit" },
				{ key = "o", action = "edit" },
				{ key = "<cr>", action = "edit" },
				{ key = "I", action = "toggle_ignored" },
				{ key = "H", action = "toggle_dotfiles" },
				{ key = "R", action = "refresh" },
				{ key = "=", action = "preview" },
				{ key = "X", action = "xdg_open", action_cb = xdg_open },
			},
		},
	},
})
