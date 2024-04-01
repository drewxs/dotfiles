local cmp = require("cmp")
local lspkind = require("lspkind")

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

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
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
      mode = "symbol", -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    }),
  },
  window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:CmpNormal",
    },
  },
})

-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
--
-- vim.cmd([[
--   set completeopt=menuone,noinsert,noselect
--   highlight! default link CmpItemKind CmpItemMenuDefault
-- ]])
