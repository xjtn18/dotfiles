require("conform").setup({
  formatters = {
    prettier = {
      -- Correctly adds environment args to the prettier formatter
      env = {
        PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/dev/projects/cvo_website/.prettierrc.json'),
      },
    },
  },
})
