require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup {
  ensure_installed = {
    "lua_ls",
    "tsserver",
    "eslint"
  },
}


-- My attempt at getting neovim client wait longer before sending the new contents to the language servers. Doesn't appear to work :/

--[[
mason_lspconfig.setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      flags = {
        debounce_text_changes = 5000
      },
    }
  end,
}
--]]
