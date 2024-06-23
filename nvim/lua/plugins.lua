return {
  -- base
  { "nvim-lua/plenary.nvim" },
  { "folke/which-key.nvim" },

  -- themes
  { "tjdevries/colorbuddy.nvim" },
  { "catppuccin/nvim" },
  { "olimorris/onedarkpro.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "folke/tokyonight.nvim" },
  { "marko-cerovac/material.nvim" },
  { "kvrohit/substrata.nvim" },
  { "kvrohit/mellow.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "svrana/neosolarized.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "Shatur/neovim-ayu" },
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },

  -- UI
  { "xiyaowong/nvim-transparent" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "nvim-tree/nvim-tree.lua",
    name = "nvim_tree",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "akinsho/toggleterm.nvim" },
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
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
    },
  },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "mfussenegger/nvim-lint" },
  { "stevearc/conform.nvim" },
  { "glepnir/lspsaga.nvim" },
  { "onsails/lspkind-nvim" },
  { "RRethy/vim-illuminate" },
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
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup()
    end,
  },
  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  -- { "github/copilot.vim" },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end,
  },

  -- utils
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
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
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  { "ziontee113/color-picker.nvim" },
}
