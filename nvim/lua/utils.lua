local default_opts = { silent = true, nowait = true }
local keymap_set = vim.keymap.set

---@param mode string | table
---@param lhs string | table
---@param rhs string | function
---@param opts table
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

---@param buf string
local function is_open(buf)
  for _, win in pairs(vim.api.nvim_list_wins()) do
    local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
    if bufname:match(buf) then
      return true
    end
  end
  return false
end

return {
  map = map,
  is_open = is_open,
}
