return {
  -- base
  { "nvim-lua/plenary.nvim" },
  { "folke/which-key.nvim" },

  -- themes
  { "catppuccin/nvim", priority = 1000 },
  { "olimorris/onedarkpro.nvim", priority = 1000 },
  { "EdenEast/nightfox.nvim", priority = 1000 },
  { "folke/tokyonight.nvim", priority = 1000 },
  { "marko-cerovac/material.nvim", priority = 1000 },
  { "kvrohit/substrata.nvim", priority = 1000 },
  { "projekt0n/github-nvim-theme", priority = 1000 },
  { "craftzdog/solarized-osaka.nvim", priority = 1000 },
  { "rebelot/kanagawa.nvim", priority = 1000 },
  { "Shatur/neovim-ayu", priority = 1000 },
  { "ellisonleao/gruvbox.nvim", priority = 1000 },

  -- UI
  { "xiyaowong/nvim-transparent" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "nvim-tree/nvim-tree.lua",
    name = "nvim_tree",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "akinsho/toggleterm.nvim", lazy = true },
  { "nvim-lualine/lualine.nvim" },
  { "akinsho/bufferline.nvim", dependencies = { "catppuccin/nvim" } },
  { "MunifTanjim/nui.nvim" },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
  },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- LSP
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
  { "saadparwaiz1/cmp_luasnip" },
  { "mfussenegger/nvim-lint" },
  { "stevearc/conform.nvim" },
  { "glepnir/lspsaga.nvim" },
  { "onsails/lspkind-nvim" },
  { "RRethy/vim-illuminate" },
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup()
    end,
  },
  -- { "github/copilot.vim", lazy = true },
  { "supermaven-inc/supermaven-nvim", lazy = true },
  { "mfussenegger/nvim-dap", lazy = true },

  -- utils
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "IndianBoy42/tree-sitter-just" },
  { "numToStr/Comment.nvim", dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" } },
  { "windwp/nvim-ts-autotag" },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "lewis6991/gitsigns.nvim" },
  { "kdheepak/lazygit.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "famiu/bufdelete.nvim" },
  { "mg979/vim-visual-multi" },
  { "ggandor/lightspeed.nvim" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  { "ziontee113/color-picker.nvim", lazy = true },
}
