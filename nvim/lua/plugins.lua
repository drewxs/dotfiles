return {
  -- base
  { "nvim-lua/plenary.nvim", lazy = false },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },

  -- themes
  { "catppuccin/nvim", lazy = false },
  "olimorris/onedarkpro.nvim",
  "EdenEast/nightfox.nvim",
  "folke/tokyonight.nvim",
  "marko-cerovac/material.nvim",
  "kvrohit/substrata.nvim",
  "kvrohit/mellow.nvim",
  "projekt0n/github-nvim-theme",

  -- file icons
  { "nvim-tree/nvim-web-devicons", lazy = false },

  -- file tree
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    name = "nvim_tree",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- statusline
  "nvim-lualine/lualine.nvim",

  -- bufferline
  "akinsho/bufferline.nvim",

  -- noice
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  -- LSP
  { "williamboman/mason.nvim", lazy = false },
  { "williamboman/mason-lspconfig.nvim", lazy = false },
  { "neovim/nvim-lspconfig", lazy = false },
  "jose-elias-alvarez/null-ls.nvim",
  "glepnir/lspsaga.nvim",
  "onsails/lspkind-nvim",

  -- cmp
  "hrsh7th/nvim-cmp",
  { "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" } },
  { "hrsh7th/cmp-buffer", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" } },
  { "hrsh7th/cmp-path", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" } },
  { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
  "saadparwaiz1/cmp_luasnip",

  -- generation
  "github/copilot.vim",

  -- treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- auto-highlight matches
  "RRethy/vim-illuminate",

  -- comment
  { "numToStr/Comment.nvim", dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" } },

  -- auto tag/pair
  "windwp/nvim-ts-autotag",
  "windwp/nvim-autopairs",

  -- telescope
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- git
  "lewis6991/gitsigns.nvim",
  "kdheepak/lazygit.nvim",

  -- terminal
  "akinsho/toggleterm.nvim",

  -- transparency
  "xiyaowong/nvim-transparent",

  -- buffer delete
  "famiu/bufdelete.nvim",

  -- multiline edit
  "mg979/vim-visual-multi",

  -- motion
  "ggandor/lightspeed.nvim",

  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- color picker
  "ziontee113/color-picker.nvim",
}
