-- Date and time display

local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local datetime = sbar.add("item", "datetime", {
  position = "right",
  update_freq = settings.update_freq.datetime,
  icon = {
    string = icons.calendar,
    color = colors.datetime,
  },
  label = {
    color = colors.datetime,
  },
  background = {
    border_color = colors.datetime,
  },
})

datetime:subscribe({ "routine", "forced" }, function()
  sbar.exec("date '+%-m/%-d (%a) %H:%M'", function(result)
    datetime:set({ label = { string = result:gsub("\n", "") } })
  end)
end)
