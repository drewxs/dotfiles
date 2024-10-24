local cmp = require("cmp")
local lspkind = require("lspkind")
local types = require("cmp.types")

require("vim.lsp.protocol").CompletionItemKind = {
  "", -- Text
  "", -- Method
  "", -- Function
  "", -- Constructor
  "", -- Field
  "", -- Variable
  "", -- Class
  "", -- Interface
  "", -- Module
  "", -- Property
  "", -- Unit
  "", -- Value
  "", -- Enum
  "", -- Keyword
  "", -- Snippet
  "", -- Color
  "", -- File
  "", -- Reference
  "", -- Folder
  "", -- EnumMember
  "", -- Constant
  "", -- Struct
  "", -- Event
  "", -- Operator
  "", -- TypeParameter
}

vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#0a0a0f" })

local function deprioritize_snippet(a, b)
  if a:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return false
  end
  if b:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return true
  end
end

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "crates" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
  window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:CmpNormal",
    },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      deprioritize_snippet,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.scopes,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})
