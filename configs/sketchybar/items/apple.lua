-- Apple menu with system actions popup

local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local popup_width = 150

local apple = sbar.add("item", "apple", {
  position = "left",
  icon = {
    string = icons.apple,
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 16.0,
    },
    color = colors.apple,
  },
  label = { drawing = false },
  background = { drawing = false },
  padding_left = 8,
  padding_right = 4,
  popup = {
    height = 35,
  },
})

-- Popup items
local lock = sbar.add("item", {
  position = "popup." .. apple.name,
  icon = {
    string = icons.lock,
    color = colors.apple,
    font = { size = 14.0 },
  },
  label = {
    string = "Lock Screen",
    color = colors.text,
  },
  width = popup_width,
})

local sleep = sbar.add("item", {
  position = "popup." .. apple.name,
  icon = {
    string = icons.sleep,
    color = colors.apple,
    font = { size = 14.0 },
  },
  label = {
    string = "Sleep",
    color = colors.text,
  },
  width = popup_width,
})

local restart = sbar.add("item", {
  position = "popup." .. apple.name,
  icon = {
    string = icons.restart,
    color = colors.apple,
    font = { size = 14.0 },
  },
  label = {
    string = "Restart",
    color = colors.text,
  },
  width = popup_width,
})

local shutdown = sbar.add("item", {
  position = "popup." .. apple.name,
  icon = {
    string = icons.shutdown,
    color = colors.apple,
    font = { size = 14.0 },
  },
  label = {
    string = "Shut Down",
    color = colors.text,
  },
  width = popup_width,
})

-- Event handlers
local function toggle_popup()
  local drawing = apple:query().popup.drawing == "on"
  apple:set({ popup = { drawing = not drawing } })
end

apple:subscribe("mouse.clicked", toggle_popup)
apple:subscribe("mouse.exited.global", function()
  apple:set({ popup = { drawing = false } })
end)

lock:subscribe("mouse.clicked", function()
  apple:set({ popup = { drawing = false } })
  sbar.exec("pmset displaysleepnow")
end)

sleep:subscribe("mouse.clicked", function()
  apple:set({ popup = { drawing = false } })
  sbar.exec("pmset sleepnow")
end)

restart:subscribe("mouse.clicked", function()
  apple:set({ popup = { drawing = false } })
  sbar.exec("osascript -e 'tell app \"System Events\" to restart'")
end)

shutdown:subscribe("mouse.clicked", function()
  apple:set({ popup = { drawing = false } })
  sbar.exec("osascript -e 'tell app \"System Events\" to shut down'")
end)
