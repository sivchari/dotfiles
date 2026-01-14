-- Front application display

local colors = require("colors")
local settings = require("settings")

local front_app = sbar.add("item", "front_app", {
  position = "left",
  icon = { drawing = false },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 13.0,
    },
    color = colors.front_app,
    padding_left = 10,
    padding_right = 10,
  },
  background = {
    color = colors.item_bg,
    border_color = colors.front_app,
    border_width = 2,
  },
})

front_app:subscribe("front_app_switched", function(env)
  front_app:set({ label = { string = env.INFO } })
end)
