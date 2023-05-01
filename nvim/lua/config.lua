-- /////////////////////////////////////////
-- Author: Jacob Nardone
-- File:   config.lua
-- Lang:   Lua
-- Desc:   Complimentary Lua config file for Neovim.
-- /////////////////////////////////////////

--------------------------------------------------------------------------------------------------------------------------|
-- CUSTOM CONFIGURATION |
-- _____________________/

-- Create the mappings for tabs where leader + number 'n' takes you the 'nth' tab.
for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<leader>' .. i, ':tabn ' .. i .. '<CR>', { noremap = true, silent = true })
end



--------------------------------------------------------------------------------------------------------------------------|
-- PLUGIN CONFIGURATION |
-- _____________________/

-- Auto-pairs config
require("nvim-autopairs").setup{}


-- Treesitter config
require('nvim-treesitter.configs').setup{
  ensure_installed = {'javascript', 'html', 'css', 'vim', 'lua', 'rust', 'cpp'},
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
require('treesitter-context').setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
  trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
}


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
      '--hidden',
      '-ignore-file', (os.getenv('USERPROFILE') or os.getenv('HOME')) .. '/.rgignore',
    },
  },
}


-- Dashboard config
require('dashboard').setup{
  theme = 'hyper',
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        desc = ' Apps',
        group = 'DiagnosticHint',
        action = 'Telescope app',
        key = 'a',
      },
      {
        desc = ' dotfiles',
        group = 'Number',
        action = 'Telescope dotfiles',
        key = 'd',
      },
    },
  },
}


-- Lualine config
-- Slanted gaps preset theme (from Lualine github)

local colors = {
  normal    = '#57B6F3',

  insert    = '#98B009',

  tan       = '#756E5D',
  tan_fg    = '#191817',

  middle    = '#41413F',
  middle_fg = '#827F79',

  red       = '#FF6060',
  black     = '#000000',
  white     = '#ffffff',
  orange    = '#fe8019',

  --separator = '#272e33',
  separator = '#232136', -- duskfox
}

local theme = {
  normal = {
    a = { fg = colors.black, bg = colors.normal },

    b = { fg = colors.white, bg = colors.tan },
    c = { fg = colors.middle_fg, bg = colors.middle },
    y = { fg = colors.white, bg = colors.middle },
  },

  insert = {
    a = { fg = colors.black, bg = colors.insert },
    y = { fg = colors.white, bg = colors.middle },
  },

  command = {
    a = { fg = colors.black, bg = colors.normal },
    y = { fg = colors.white, bg = colors.middle },
  },

  visual = {
    a = { fg = colors.black, bg = colors.orange },
    y = { fg = colors.white, bg = colors.middle },
  },

  replace = {
    a = { fg = colors.white, bg = colors.red },
    y = { fg = colors.white, bg = colors.middle },
  },
}

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = ''
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < 'x'
    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.normal, bg = colors.separator } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
    end
  end
  return sections
end

local function search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function modified()
  if vim.bo.modified then
    return '+'
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return '-'
  end
  return ''
end

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = process_sections {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      --'diff', -- THIS ADDS THE DIFF SECTION OF THE STATUS LINE
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'error' },
        diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'warn' },
        diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
      },
      { 'filename', file_status = false, path = 1 },
      { modified, color = { fg = colors.white, bg = colors.red } },
      {
        '%w',
        cond = function()
          return vim.wo.previewwindow
        end,
      },
      {
        '%r',
        cond = function()
          return vim.bo.readonly
        end,
      },
      {
        '%q',
        cond = function()
          return vim.bo.buftype == 'quickfix'
        end,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      search_result,
      'filetype'
    },
    lualine_z = { '%l:%c', '%p%%/%L' },
  },
  inactive_sections = {
    lualine_c = { '%f %y %m' },
    lualine_x = {},
  },
}


