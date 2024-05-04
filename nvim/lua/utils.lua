local default_opts = { silent = true, nowait = true }

return {
  map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    setmetatable(opts, { __index = default_opts })
    vim.keymap.set(mode, lhs, rhs, opts)
  end,
}
