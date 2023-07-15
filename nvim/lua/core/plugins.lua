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
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-tree/nvim-web-devicons',
  'cohama/lexima.vim',
  'herringtondarkholme/yats.vim',
  'maxmellon/vim-jsx-pretty',
  {
    'xjtn18/nightfox.nvim',
    lazy = false,
  },
  --{
    --'nvim-tree/nvim-tree.lua',
    --lazy = false,
  --},
  --'nvim-treesitter/nvim-treesitter-context',
  --'nvim-lualine/lualine.nvim',
  --'neovimhaskell/haskell-vim',
  --'neanias/everforest-nvim',
  --'UnikMask/iroh-vim',
  --'glepnir/dashboard-nvim',
}

require("lazy").setup(plugins)
