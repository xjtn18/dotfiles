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
