-- Lualine config
-- Slanted gaps preset theme (from Lualine github)

local dark_colors = {
  normal    = '#D87E34',
  normal_fg = '#4D281E',

  insert    = '#789A3D',
  insert_fg = '#2F3703',

  visual    = '#3CB19F',
  visual_fg = '#92EADD',

  tan       = '#756E5D',

  middle    = '#41413F',
  middle_fg = '#827F79',


  red       = '#c2604c',
  black     = '#000000',
  white     = '#ffffff',
  orange    = '#fe8019',

  -- separator = '#232136', -- duskfox
  separator = '#2e2b2a', -- terafox (iroh)
}

local light_colors = {
  normal    = '#57B6F3',

  insert    = '#98B009',

  tan       = '#E2D6C4',

  middle    = '#E7E4D9',
  middle_fg = '#827F79',

  red       = '#c2604c',
  black     = '#ffffff',
  white     = '#554E4A',
  orange    = '#fe8019',

  separator = '#fffbef', -- everforest
}

local colors = vim.o.background == "light" and light_colors or dark_colors

local theme = {
  normal = {
    a = { fg = colors.normal_fg, bg = colors.normal },

    b = { fg = colors.white, bg = colors.tan },
    c = { fg = colors.middle_fg, bg = colors.middle },
    y = { fg = colors.white, bg = colors.middle },
  },

  insert = {
    a = { fg = colors.insert_fg, bg = colors.insert },
    y = { fg = colors.white, bg = colors.middle },
  },

  command = {
    a = { fg = colors.normal_fg, bg = colors.normal },
    y = { fg = colors.white, bg = colors.middle },
  },

  visual = {
    a = { fg = colors.visual_fg, bg = colors.visual },
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
      --comp.separator = left and { right = '▙' } or { left = '▜' }
      --comp.separator = left and { right = '▌' } or { left = '▐' }
      --comp.separator = left and { right = '' } or { left = '' }
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
    --section_separators = { left = '', right = '' },
    disabled_filetypes = {'NvimTree'}
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

