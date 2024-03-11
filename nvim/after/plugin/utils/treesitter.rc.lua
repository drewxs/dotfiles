require("nvim-treesitter.configs").setup({
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
    "cpp",
    "c_sharp",
    "ruby",
    "java",
    "typescript",
    "javascript",
    "tsx",
    "html",
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
    enable_rename = false,
  },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
parser_config.typescript.filetype_to_parsername = { "javascript", "typescript.tsx" }
