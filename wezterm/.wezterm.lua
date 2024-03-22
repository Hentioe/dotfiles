--  ---- METADATA ----
--  Target: ~/.wezterm.lua
--  Author: Hentioe (绅士喵)
--  CreatedAt: 2024-03-20
--  UpdatedAt: 2024-03-23
--  ---- METADATA ----

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.font = wezterm.font 'Noto Sans Mono CJK SC'
config.font_size = 13
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 400
config.enable_scroll_bar = true
config.color_scheme = 'Afterglow'
config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#0b0022',

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = '#202020',
      -- The color of the text for the tab
      fg_color = '#c0c0c0',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Normal',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'None',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = '#484848',
      fg_color = '#ADADAD',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    }
  },
  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#484848'
}
config.window_frame = {
  font_size = 13
}
config.window_background_opacity = 1
config.initial_cols = 150
config.initial_rows = 34
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
