local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup {
  options = {
    buffer_close_icon = '',
    modified_icon = '',
    close_icon = '',
    show_close_icon = false,
    left_trunc_marker = '',
    right_trunc_marker = '',
    color_icons = true,
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        text_align = 'center',
        separator = false
      },
    },
  }
}
