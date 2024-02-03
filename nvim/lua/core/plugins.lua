local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
  'nvim-treesitter/nvim-treesitter',
  'herringtondarkholme/yats.vim',
  'maxmellon/vim-jsx-pretty',
  'cohama/lexima.vim',
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',
  'nvim-telescope/telescope.nvim',
  {
    'xjtn18/nightfox.nvim',
    lazy = false,
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {
        'L3MON4D3/LuaSnip',     -- Required
        dependencies = {
          'saadparwaiz1/cmp_luasnip',
          'rafamadriz/friendly-snippets',
        },
      },
    },
    lazy = false,
  },
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
  },
  'nvim-treesitter/nvim-treesitter-context',
  --'nvim-lualine/lualine.nvim',
  --'glepnir/dashboard-nvim',
  'ojroques/nvim-osc52',
}

require("lazy").setup(plugins)
