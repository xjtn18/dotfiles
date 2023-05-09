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


function source_config()
  -- Source init.vim and lua/config.lua (this file)
  vim.api.nvim_command('source ' .. vim.fn.stdpath('config') .. '/init.vim')
  vim.api.nvim_command('luafile ' .. vim.fn.stdpath('config') .. '/lua/config.lua')

  -- Trigger FileType autocmd manually (so that any file-specific config will execute)
  vim.api.nvim_command('silent! doautocmd FileType')
end


-- Makes it to that vim and system share the same clipboard
vim.api.nvim_set_option("clipboard","unnamed")


--------------------------------------------------------------------------------------------------------------------------|
-- PLUGIN CONFIGURATION |
-- _____________________/

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


-- MY COLOR SCHEME

local Shade = require("nightfox.lib.shade")
local nightfox = require('nightfox')

nightfox.setup{
  palettes = {
    terafox = {
      fg1 = '#D87E34', -- cursor
      fg2 = '#88756D', -- special chars, inactive tab fg
      fg3 = '#7d5650', -- line numbers


      bg0  = '#272524', -- secondary bg
      bg1  = '#2e2b2a', -- main bg
      bg2  = '#3B3534', -- Conceal, border fg
      bg3  = '#3B3534', -- Lighter bg (cursor line)
      bg4  = '#d6caab', -- Conceal, border fg (telescope border)

      sel0 = '#3B5754', -- Popup bg, visual selection bg
      comment = '#634C47',

      white   = Shade.new('#d6caab', '#eeeeee', '#c8c8c8'),  -- 1: variables
      magenta = Shade.new('#c2604c', '#789B98', '#934e69'),  -- 1: keywords, 2: control flow
      green   = Shade.new('#808A4A', '#8eb2af', '#688b89'),  -- 1: strings
      yellow  = Shade.new('#E7AC4E', '#fdb292', '#d78b6c'),  -- 1: Imports, cursor line number
      --blue    = Shade.new('#D7B86A', '#d6caab', '#4d7d90'),  -- 1: attrs, 2: functions, tags
      blue    = Shade.new('#d6caab', '#AFA489', '#4d7d90'),  -- 1: attrs, 2: functions, tags
      cyan    = Shade.new('#E7AC4E', '#899470', '#89aeb8'),  -- 1: classes, elements, 2: parameters
      orange  = Shade.new('#9eb185', '#E7AC4E', '#d96f3e'),  -- 1: numbers, 2: constants
      red     = Shade.new('#c2604c', '#eb746b', '#c54e45'),  -- 1: statements
      pink    = Shade.new('#cb7985', '#789B98', '#ad6771'),  -- 2: preproc
    }
  }
}

-- NOTE: Nightfox comes with a command ':NightfoxInteractive' which makes it so that upon save,
--       the scheme is automatically recompiled. This is usefule when you are making changes.


-- Actually set the colorscheme
vim.cmd('colorscheme terafox')



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


-- Neovide config

-- Check if Neovide is running
if vim.g.neovide then
    -- Function with the first set of values
    local function neovide_config_home()
        vim.cmd("cd ~/dev")
        vim.opt.guifont = "Cousine NFM:h13"
      
        vim.g.neovide_cursor_vfx_mode = "pixiedust"
      
        vim.g.neovide_cursor_vfx_particle_density = 14.0
        vim.g.neovide_cursor_vfx_particle_lifetime = 3.0
        vim.g.neovide_cursor_animation_length = 0.02
        vim.g.neovide_hide_mouse_when_typing = true
      
        vim.g.neovide_refresh_rate = 120
        vim.g.neovide_refresh_rate_idle = 60
    end

    -- Function with the second set of values (change the values as needed)
    local function neovide_config_work()
        vim.cmd("cd ~/dev")
        vim.opt.guifont = "Cousine NFM:h13"
      
        vim.g.neovide_cursor_vfx_mode = ""
        vim.g.neovide_cursor_animation_length = 0
        vim.g.neovide_hide_mouse_when_typing = true
      
        vim.g.neovide_refresh_rate = 30
        vim.g.neovide_refresh_rate_idle = 30
    end

    --neovide_config_home()
    neovide_config_work()
end

