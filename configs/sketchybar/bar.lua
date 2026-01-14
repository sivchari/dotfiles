-- Bar configuration

local colors = require("colors")

sbar.bar({
  height = 32,
  blur_radius = 30,
  position = "top",
  sticky = true,
  padding_left = 8,
  padding_right = 8,
  color = colors.bar_bg,
  shadow = true,
  y_offset = 0,
})
