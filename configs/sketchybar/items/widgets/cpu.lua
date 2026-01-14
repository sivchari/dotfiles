-- CPU usage display

local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local cpu = sbar.add("item", "widgets.cpu", {
  position = "right",
  update_freq = settings.update_freq.cpu,
  icon = {
    string = icons.cpu,
    color = colors.cpu,
  },
  label = {
    string = "??%",
    color = colors.cpu,
    font = { family = settings.font.numbers },
    align = "right",
  },
  padding_right = 0,
  padding_left = 5,
})

sbar.add("bracket", "widgets.cpu.bracket", { cpu.name }, {
  background = { color = colors.item_bg, border_color = colors.cpu, border_width = 2 },
})

cpu:subscribe({ "routine", "forced" }, function()
  sbar.exec("/usr/bin/top -l 1 -n 0 | grep 'CPU usage' | awk '{print $3}' | tr -d '%'", function(result)
    local usage = result:gsub("\n", "")
    if usage == "" then
      cpu:set({ label = { string = "N/A" } })
    else
      cpu:set({ label = { string = usage .. "%" } })
    end
  end)
end)

cpu:subscribe("mouse.clicked", function()
  sbar.exec("open -a 'Activity Monitor'")
end)

sbar.add("item", { position = "right", width = settings.group_paddings })
