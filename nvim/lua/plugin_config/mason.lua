require("mason").setup()

local lspconfig = require('lspconfig')
local mason_lspconfig = require("mason-lspconfig")



local handlers = {
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["ts_ls"] = function()
    lspconfig.ts_ls.setup {
      --[[
      flags = {
        debounce_text_changes = 5000
      },
      ]]
    }
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          -- This gets rid of the annoying warnings about 'vim' and 'require'.
          diagnostics = {
            globals = {
              'vim',
              'require',
            }
          }
        }
      }
    }
  end,
  ["pyright"] = function()
    lspconfig.pyright.setup {
      settings = {
        python = {
          analysis = {
            extraPaths = {
              "/home/ec2-user/dev/projects/Layers/aws_helpers/python/lib/python3.11/site-packages",
              "/home/ec2-user/dev/projects/Layers/database_utils_layer/python/lib/python3.11/site-packages"
            },
          },
        },
      },
    }
  end,
}

mason_lspconfig.setup({
  handlers = handlers,
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "eslint",
    "pyright",
    "jsonls",
    "rust_analyzer",
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
