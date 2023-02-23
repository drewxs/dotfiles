local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

ts.setup({
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "rust",
    "lua",
    "c",
    "cpp",
    "c_sharp",
    "ruby",
    "go",
    "swift",
    "java",
    "typescript",
    "javascript",
    "tsx",
    "php",
    "html",
    "vue",
    "scss",
    "css",
    "sql",
    "graphql",
    "regex",
    "bash",
    "json",
    "yaml",
    "toml",
    "markdown",
    "markdown_inline",
    "dockerfile",
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  autotag = {
    enable = true,
  },
})

-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

local ts_js_commentstring_config = {
  __default = "// %s",
  __multiline = "/* %s */",
  jsx_element = "{/* %s */}",
  jsx_fragment = "{/* %s */}",
  jsx_attribute = "// %s",
  comment = "// %s",
}

require("nvim-treesitter.configs").setup({
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      javascript = ts_js_commentstring_config,
      typescript = ts_js_commentstring_config,
    },
  },
})
