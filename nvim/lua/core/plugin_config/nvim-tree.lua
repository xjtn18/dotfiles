-- NVim-tree config
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Show dotfiles
vim.g.nvim_tree_hide_dotfiles = 0

vim.g.nvim_tree_respect_buf_cwd = 1

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 50,
    side = 'left',
    signcolumn='no'
  },
  renderer = {
    group_empty = true,
  },
})
