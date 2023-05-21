-- NVim-tree config
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 60,
    side = 'left',
    signcolumn='no'
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
