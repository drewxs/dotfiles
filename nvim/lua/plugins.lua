return {
  -- base
  { "nvim-lua/plenary.nvim" },

  -- which-key
  { "folke/which-key.nvim" },

  -- themes
  {
    "tjdevries/colorbuddy.nvim",
    config = function()
      require("colorbuddy").setup()
    end,
  },
  { "catppuccin/nvim" },
  { "olimorris/onedarkpro.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "folke/tokyonight.nvim" },
  { "marko-cerovac/material.nvim" },
  { "kvrohit/substrata.nvim" },
  { "kvrohit/mellow.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "svrana/neosolarized.nvim" },

  -- file icons
  { "nvim-tree/nvim-web-devicons" },

  -- file tree
  {
    "nvim-tree/nvim-tree.lua",
    name = "nvim_tree",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- statusline
  { "nvim-lualine/lualine.nvim" },

  -- bufferline
  { "akinsho/bufferline.nvim", dependencies = { "catppuccin/nvim" } },

  -- noice
  { "MunifTanjim/nui.nvim" },
  { "rcarriga/nvim-notify" },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  },

  -- LSP
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "nvimtools/none-ls.nvim" },
  { "glepnir/lspsaga.nvim" },
  { "onsails/lspkind-nvim" },

  -- cmp
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

  -- generation
  { "github/copilot.vim" },

  -- treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- auto-highlight matches
  { "RRethy/vim-illuminate" },

  -- comment
  { "numToStr/Comment.nvim", dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" } },

  -- auto tag/pair
  { "windwp/nvim-ts-autotag" },
  { "windwp/nvim-autopairs" },

  -- telescope
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- git
  { "lewis6991/gitsigns.nvim" },
  { "kdheepak/lazygit.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- terminal
  { "akinsho/toggleterm.nvim" },

  -- transparency
  { "xiyaowong/nvim-transparent" },

  -- buffer delete
  { "famiu/bufdelete.nvim" },

  -- motions
  { "mg979/vim-visual-multi" },
  { "ggandor/lightspeed.nvim" },

  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- color picker
  { "ziontee113/color-picker.nvim" },

  -- rust crates
  { "saecki/crates.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
}
