local status, map = pcall(require, "mini.map")
if not status then
  return
end

map.setup({
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.diagnostic({
      error = "DiagnosticFloatingError",
      warn = "DiagnosticFloatingWarn",
      info = "DiagnosticFloatingInfo",
      hint = "DiagnosticFloatingHint",
    }),
  },
  symbols = {
    encode = map.gen_encode_symbols.dot("4x2"),
  },
  window = {
    side = "right",
    width = 20,
    winblend = 100,
    show_integration_count = false,
  },
})

map.open()
