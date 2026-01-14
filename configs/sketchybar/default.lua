-- Default item settings

local colors = require("colors")
local settings = require("settings")

sbar.default({
  icon = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 14.0,
    },
    color = colors.text,
    padding_left = 8,
    padding_right = 4,
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 12.0,
    },
    color = colors.text,
    padding_left = 4,
    padding_right = 8,
  },
  background = {
    color = colors.item_bg,
    corner_radius = 6,
    height = 26,
    border_width = 0,
  },
  padding_left = settings.paddings,
  padding_right = settings.paddings,
  popup = {
    background = {
      color = colors.popup_bg,
      border_color = colors.popup_border,
      border_width = 2,
      corner_radius = 10,
    },
    blur_radius = 30,
  },
})
