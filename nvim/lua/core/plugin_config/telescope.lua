-- Telescope config
require('telescope').setup{
  defaults = {
    mappings = {
      n = { -- Normal mode mappings
        ['<c-d>'] = require('telescope.actions').delete_buffer
      },
    },
    ripgrep_arguments = {
      'rg',
      '-ignore-file', (os.getenv('USERPROFILE') or os.getenv('HOME')) .. '/.rgignore',
    },
  },
}

