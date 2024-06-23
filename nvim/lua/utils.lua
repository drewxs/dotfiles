local default_opts = { silent = true, nowait = true }
local keymap_set = vim.keymap.set

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  if not getmetatable(opts) then
    setmetatable(opts, { __index = default_opts })
  end

  if type(lhs) == "table" then
    for _, cmd in ipairs(lhs) do
      keymap_set(mode, cmd, rhs, opts)
    end
  else
    keymap_set(mode, lhs, rhs, opts)
  end
end

return {
  map = map,
}
