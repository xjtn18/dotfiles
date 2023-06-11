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
  --'glepnir/dashboard-nvim',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'maxmellon/vim-jsx-pretty',
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-context',
  --'nvim-lualine/lualine.nvim',
  'nvim-tree/nvim-web-devicons',
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
  },
  'cohama/lexima.vim',
  --'neovimhaskell/haskell-vim',
  --'neanias/everforest-nvim',
  --'UnikMask/iroh-vim',
  {
    'xjtn18/nightfox.nvim',
    lazy = false,
  },
}

require("lazy").setup(plugins)
