local status, packer = pcall(require, 'packer')
if (not status) then
  print('Packer is not installed')
  return
end

vim.cmd [[packadd packer.nvim]]

-- plugins
packer.startup(function(use)
  -- base
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'lewis6991/impatient.nvim'

  -- themes
  use 'olimorris/onedarkpro.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'folke/tokyonight.nvim'
  use 'marko-cerovac/material.nvim'

  -- file icons
  use 'kyazdani42/nvim-web-devicons'

  -- statusline
  use 'nvim-lualine/lualine.nvim'

  -- bufferline
  use 'akinsho/bufferline.nvim'

  -- file tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
    tag = 'nightly',
    cmd = 'NvimTreeToggle'
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'glepnir/lspsaga.nvim'
  use 'onsails/lspkind-nvim'

  -- cmp
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- snippets
  use 'L3MON4D3/LuaSnip'

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- comment
  use 'numToStr/Comment.nvim'

  -- auto tag/pair
  use 'windwp/nvim-ts-autotag'
  use 'windwp/nvim-autopairs'

  -- telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- formatting
  use 'prettier/vim-prettier'

  -- git
  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim'

  -- mason
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- terminal
  use 'akinsho/toggleterm.nvim'

  -- transparent background
  use 'xiyaowong/nvim-transparent'

  -- which-key
  use 'folke/which-key.nvim'

  -- alpha
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    cmd = {
      'Alpha',
      'AlphaRedraw'
    }
  }

  -- buffer delete
  use 'famiu/bufdelete.nvim'

  -- multiline edit
  use 'mg979/vim-visual-multi'
end)
