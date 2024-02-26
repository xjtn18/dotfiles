-- MY COLOR SCHEME

local Shade = require("nightfox.lib.shade")



local my_orange = '#A38974' or '#e88635'
local my_yellow = '#E7AC4E'
local my_white = '#d6caab';
local my_red = '#c97160';
local my_quiet = '#56423e'
local my_gray = '#AFA489'
local my_blue = '#789B98';
local my_green = '#808A4A';
local my_dark_teal = '#899470';
local my_light_teal = '#9eb185';
local my_water = '#3B5754';
local my_bg = '#262423' or '#1c1a1a';
local my_light = '#2C2726' or '#3B3534';



require('nightfox').setup{
  palettes = {
    terafox = {
      fg1 = my_white, -- cursor

      fg2 = '#88756D', -- special chars, inactive tab fg
      fg3 = my_quiet, -- line numbers

      bg0  = '#272524', -- secondary bg
      bg1  = my_bg, -- main bg
      bg2  = my_light, -- Conceal, border fg
      bg3  = my_light, -- Lighter bg (cursor line)
      bg4  = my_gray, -- Conceal, border fg (telescope border)

      sel0 = my_water, -- Popup bg, visual selection bg
      comment = my_quiet,

      white   = Shade.new(my_white, '#eeeeee', '#c8c8c8'),  -- 1: variables
      magenta = Shade.new(my_red, my_blue, '#934e69'),  -- 1: keywords, 2: control flow
      green   = Shade.new(my_green, '#8eb2af', '#688b89'),  -- 1: strings
      yellow  = Shade.new(my_yellow, '#fdb292', '#d78b6c'),  -- 1: Imports, cursor line number
      blue    = Shade.new(my_white, my_gray, '#4d7d90'),  -- 1: attrs, 2: functions, tags
      cyan    = Shade.new(my_orange, my_dark_teal, '#89aeb8'),  -- 1: classes, elements, 2: parameters
      orange  = Shade.new(my_light_teal, my_yellow, '#d96f3e'),  -- 1: numbers, 2: constants
      red     = Shade.new(my_orange, '#eb746b', '#c54e45'),  -- 1: statements
      pink    = Shade.new('#cb7985', my_blue, '#ad6771'),  -- 2: preproc
    }
  },
  groups = {
    terafox = {
      Visual = { fg = my_gray }, -- Override fg of visual selections to improve legibility.
      Todo = { bg = my_bg, fg = my_yellow },
    }
  }
}

