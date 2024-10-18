local function get_colorschemes()
  local colorschemes = {}

  -- Path to Lazy-managed colorschemes
  local lazy_colorscheme_dir = vim.fn.stdpath('data') .. "/lazy/"
  local default_colorscheme_dir = vim.fn.expand("$VIMRUNTIME/colors/")

  -- Function to find colorschemes in a given directory
  local function find_colorschemes(dir)
    local handle = io.popen('find "' .. dir .. '" -type f -path "*/colors/*.vim"')
    if handle then
      for file in handle:lines() do
        local name = file:match(".*/([^/]+)%.vim$")
        if name then
          table.insert(colorschemes, name)
        end
      end
      handle:close()
    end
  end

  -- Find Lazy-managed colorschemes
  find_colorschemes(lazy_colorscheme_dir)

  -- Find default Neovim colorschemes
  local handle = io.popen('find "' .. default_colorscheme_dir .. '" -type f -name "*.vim"')
  if handle then
    for file in handle:lines() do
      local name = file:match(".*/([^/]+)%.vim$")
      if name then
        table.insert(colorschemes, name)
      end
    end
    handle:close()
  end

  return colorschemes
end

local schemes = get_colorschemes()

--[[ For testing...
for _, scheme in ipairs(schemes) do
  vim.cmd('echomsg "' .. vim.fn.escape(scheme, '"') .. '"')
end
--]]

-- Minimal config
require("themery").setup({
  themes = schemes,   -- Include all collected colorschemes.
  livePreview = true, -- Apply theme while picking. Default to true.
})
