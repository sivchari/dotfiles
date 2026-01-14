-- WiFi display with speed info

local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local popup_width = 250

local wifi = sbar.add("item", "widgets.wifi", {
  position = "right",
  icon = {
    string = icons.wifi.connected,
    color = colors.wifi,
  },
  label = {
    string = "...",
    color = colors.wifi,
    font = { family = settings.font.numbers, size = 10.0 },
    width = 130,
    align = "right",
  },
  padding_left = 5,
  padding_right = 5,
})

sbar.add("bracket", "widgets.wifi.bracket", { wifi.name }, {
  background = { color = colors.item_bg, border_color = colors.wifi, border_width = 2 },
})

-- Popup items
local ssid = sbar.add("item", {
  position = "popup." .. wifi.name,
  icon = {
    font = { size = 13.0, style = settings.font.style_map["Bold"] },
    string = icons.wifi.router,
    color = colors.wifi,
  },
  width = popup_width,
  align = "center",
  label = {
    font = { style = settings.font.style_map["Bold"] },
    max_chars = 18,
    string = "????????????",
    color = colors.wifi,
  },
  background = { height = 2, color = colors.surface1, y_offset = -15 },
})

local hostname = sbar.add("item", {
  position = "popup." .. wifi.name,
  icon = { font = { size = 13.0 }, align = "left", string = "Hostname:", width = popup_width / 2, color = colors.wifi },
  label = { max_chars = 20, string = "????????????", width = popup_width / 2, align = "right", color = colors.wifi },
})

local ip = sbar.add("item", {
  position = "popup." .. wifi.name,
  icon = { font = { size = 13.0 }, align = "left", string = "IP:", width = popup_width / 2, color = colors.wifi },
  label = { string = "???.???.???.???", width = popup_width / 2, align = "right", color = colors.wifi },
})

local mask = sbar.add("item", {
  position = "popup." .. wifi.name,
  icon = { font = { size = 13.0 }, align = "left", string = "Subnet mask:", width = popup_width / 2, color = colors.wifi },
  label = { string = "???.???.???.???", width = popup_width / 2, align = "right", color = colors.wifi },
})

local router_item = sbar.add("item", {
  position = "popup." .. wifi.name,
  icon = { font = { size = 13.0 }, align = "left", string = "Router:", width = popup_width / 2, color = colors.wifi },
  label = { string = "???.???.???.???", width = popup_width / 2, align = "right", color = colors.wifi },
})

wifi:subscribe("network_update", function(env)
  local up = env.upload or "0 B/s"
  local down = env.download or "0 B/s"

  -- Format: "↑X ↓Y" using Unicode arrows
  wifi:set({
    label = { string = "↑" .. up .. " ↓" .. down },
  })
end)

wifi:subscribe({ "wifi_change", "system_woke", "forced" }, function()
  sbar.exec("ipconfig getifaddr en0", function(result)
    local connected = not (result == "")
    wifi:set({
      icon = {
        string = connected and icons.wifi.connected or icons.wifi.disconnected,
        color = connected and colors.wifi or colors.surface1,
      },
    })
  end)
end)

local function hide_details()
  wifi:set({ popup = { drawing = false } })
end

local function toggle_details()
  local should_draw = wifi:query().popup.drawing == "off"
  if should_draw then
    wifi:set({ popup = { drawing = true } })
    sbar.exec("networksetup -getcomputername", function(result)
      hostname:set({ label = result })
    end)
    sbar.exec("ipconfig getifaddr en0", function(result)
      ip:set({ label = result })
    end)
    sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(result)
      ssid:set({ label = result })
    end)
    sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Subnet mask: ' '/^Subnet mask: / {print $2}'", function(result)
      mask:set({ label = result })
    end)
    sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result)
      router_item:set({ label = result })
    end)
  else
    hide_details()
  end
end

wifi:subscribe("mouse.clicked", toggle_details)
wifi:subscribe("mouse.exited.global", hide_details)

local function copy_label_to_clipboard(env)
  local label = sbar.query(env.NAME).label.value
  sbar.exec('echo "' .. label .. '" | pbcopy')
  sbar.set(env.NAME, { label = { string = icons.clipboard, align = "center" } })
  sbar.delay(1, function()
    sbar.set(env.NAME, { label = { string = label, align = "right" } })
  end)
end

ssid:subscribe("mouse.clicked", copy_label_to_clipboard)
hostname:subscribe("mouse.clicked", copy_label_to_clipboard)
ip:subscribe("mouse.clicked", copy_label_to_clipboard)
mask:subscribe("mouse.clicked", copy_label_to_clipboard)
router_item:subscribe("mouse.clicked", copy_label_to_clipboard)

sbar.add("item", { position = "right", width = settings.group_paddings })
