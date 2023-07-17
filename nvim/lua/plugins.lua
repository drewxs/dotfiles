local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- plugins
require("packer").startup(function(use)
  -- base
  use("wbthomason/packer.nvim")
  use("nvim-lua/plenary.nvim")

  -- themes
  use("olimorris/onedarkpro.nvim")
  use("EdenEast/nightfox.nvim")
  use("folke/tokyonight.nvim")
  use("marko-cerovac/material.nvim")
  use("catppuccin/nvim")
  use("kvrohit/substrata.nvim")
  use("kvrohit/mellow.nvim")
  use("projekt0n/github-nvim-theme")

  -- file icons
  use("nvim-tree/nvim-web-devicons")

  -- file tree
  use({
    "nvim-tree/nvim-tree.lua",
    as = "nvim_tree",
    requires = { "nvim-tree/nvim-web-devicons" },
    tag = "nightly",
  })

  -- statusline
  use("nvim-lualine/lualine.nvim")

  -- bufferline
  use("akinsho/bufferline.nvim")

  -- LSP
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("neovim/nvim-lspconfig")
  use("glepnir/lspsaga.nvim")
  use("onsails/lspkind-nvim")

  -- cmp
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")

  -- snippets
  use({
    "L3MON4D3/LuaSnip",
    run = "make install_jsregexp",
  })
  use("github/copilot.vim")

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- auto-highlight matches
  use("RRethy/vim-illuminate")

  -- comment
  use({
    "numToStr/Comment.nvim",
    requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
  })

  -- auto tag/pair
  use("windwp/nvim-ts-autotag")
  use("windwp/nvim-autopairs")

  -- telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  -- git
  use("lewis6991/gitsigns.nvim")
  use("kdheepak/lazygit.nvim")

  -- terminal
  use("akinsho/toggleterm.nvim")

  -- transparency
  use("xiyaowong/nvim-transparent")

  -- which-key
  use("folke/which-key.nvim")

  -- buffer delete
  use("famiu/bufdelete.nvim")

  -- multiline edit
  use("mg979/vim-visual-multi")

  -- motion
  use("ggandor/lightspeed.nvim")

  -- markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })

  -- color picker
  use("ziontee113/color-picker.nvim")

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
