require("mason").setup()

local lspconfig = require('lspconfig')
local mason_lspconfig = require("mason-lspconfig")



local handlers = {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["tsserver"] = function ()
    lspconfig.tsserver.setup {
      --[[
      flags = {
        debounce_text_changes = 5000
      },
      ]]
    }
  end,
}

mason_lspconfig.setup({
  handlers = handlers,
  ensure_installed = {
    "lua_ls",
    "tsserver",
    "eslint",
    "pyright",
  },
})


-- My attempt at getting neovim client wait longer before sending the new contents to the language servers. Doesn't appear to work :/

--[[
mason_lspconfig.setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
    }
  end,
  ]]
