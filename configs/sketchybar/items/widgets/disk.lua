-- Disk usage display

local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local disk = sbar.add("item", "widgets.disk", {
  position = "right",
  update_freq = settings.update_freq.disk,
  icon = {
    string = icons.disk,
    color = colors.disk,
  },
  label = {
    string = "??/??",
    color = colors.disk,
    font = { family = settings.font.numbers },
    align = "right",
  },
  padding_right = 0,
  padding_left = 5,
})

sbar.add("bracket", "widgets.disk.bracket", { disk.name }, {
  background = { color = colors.item_bg, border_color = colors.disk, border_width = 2 },
})

disk:subscribe({ "routine", "forced" }, function()
  sbar.exec("df -H / | tail -1 | awk '{print $3\"/\"$2}'", function(result)
    local usage = result:gsub("\n", "")
    if usage == "" then
      disk:set({ label = { string = "N/A" } })
    else
      disk:set({ label = { string = usage } })
    end
  end)
end)

sbar.add("item", { position = "right", width = settings.group_paddings })
