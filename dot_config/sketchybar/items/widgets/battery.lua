-- Battery status display

local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local popup_width = 200

local battery = sbar.add("item", "widgets.battery", {
  position = "right",
  update_freq = settings.update_freq.battery,
  icon = {
    font = { style = settings.font.style_map["Regular"], size = 19.0 },
    padding_left = 9,
    padding_right = 0,
  },
  label = {
    font = { family = settings.font.numbers },
    color = colors.battery,
  },
  padding_left = 0,
  padding_right = 5,
  popup = { align = "center" },
})

sbar.add("bracket", "widgets.battery.bracket", { battery.name }, {
  background = { color = colors.item_bg, border_color = colors.battery, border_width = 2 },
})

-- Popup items
local time_remaining = sbar.add("item", {
  position = "popup." .. battery.name,
  icon = {
    string = "Remaining:",
    color = colors.battery,
    font = { size = 13.0 },
    width = popup_width / 2,
    align = "left",
  },
  label = {
    string = "??:??h",
    color = colors.battery,
    width = popup_width / 2,
    align = "right",
  },
})

local function update_battery()
  sbar.exec("pmset -g batt", function(result)
    local percent = result:match("(%d+)%%")
    local charging = result:match("AC Power") ~= nil
    local time_left = result:match("(%d+:%d+) remaining")

    if not percent then
      battery:set({ label = { string = "N/A" } })
      return
    end

    local pct = tonumber(percent)
    local icon = icons.battery_full
    local color = colors.battery

    if charging then
      icon = icons.charging
    else
      if pct > 80 then
        icon = icons.battery_full
      elseif pct > 60 then
        icon = icons.battery_three
      elseif pct > 40 then
        icon = icons.battery_half
      elseif pct > 20 then
        icon = icons.battery_one
        color = colors.peach
      else
        icon = icons.battery_empty
        color = colors.red
      end
    end

    battery:set({
      icon = { string = icon, color = color },
      label = { string = percent .. "%" },
    })

    time_remaining:set({
      label = { string = time_left or (charging and "Charging" or "N/A") },
    })
  end)
end

battery:subscribe({ "routine", "forced", "system_woke", "power_source_change" }, update_battery)

battery:subscribe("mouse.clicked", function()
  battery:set({ popup = { drawing = "toggle" } })
end)

battery:subscribe("mouse.exited.global", function()
  battery:set({ popup = { drawing = false } })
end)

sbar.add("item", { position = "right", width = settings.group_paddings })
