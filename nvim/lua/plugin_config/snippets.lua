local luasnip = require 'luasnip'

require('luasnip.loaders.from_vscode').lazy_load()

-- Note that the extension table keys should match the filenames in the ".local/share/nvim/lazy/friendly-snippets/snippets/{language}" folder
luasnip.filetype_extend('typescriptreact', { 'jsdoc' }) -- Add jsdoc snippets to typescriptreact!
luasnip.filetype_extend('typescript', { 'jsdoc' })      -- Add jsdoc snippets to typescript!

luasnip.filetype_extend('python', { 'pydoc' })          -- Add pydoc snippets to python!

luasnip.config.setup {}
