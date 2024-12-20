require("bufferline").setup({
  options = {
    close_command = "Bdelete! %d",
    diagnostics = "nvim_lsp",
    offsets = {
      { filetype = "NvimTree", separator = false },
    },
    color_icons = false,
    show_buffer_icons = false,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true,
    persist_buffer_sort = true,
    separator_style = "slope",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    sort_by = "id",
  },
})
