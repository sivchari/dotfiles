-- Bluetooth display with device list popup and battery info

local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local popup_width = 250
local max_devices = 5
local BLUEUTIL = os.getenv("HOME") .. "/.local/bin/blueutil"
local BTMON = os.getenv("HOME") .. "/.local/bin/btmon"

local bluetooth = sbar.add("item", "widgets.bluetooth", {
  position = "right",
  update_freq = settings.update_freq.bluetooth,
  icon = {
    string = icons.bluetooth.on,
    color = colors.bluetooth,
  },
  label = {
    color = colors.bluetooth,
    font = { family = settings.font.numbers },
  },
  padding_left = 0,
  padding_right = 5,
  popup = { height = 35 },
})

sbar.add("bracket", "widgets.bluetooth.bracket", { bluetooth.name }, {
  background = { color = colors.item_bg, border_color = colors.bluetooth, border_width = 2 },
})

-- Power toggle item in popup
local power_toggle = sbar.add("item", "bluetooth.power", {
  position = "popup." .. bluetooth.name,
  icon = {
    string = icons.bluetooth.on,
    color = colors.bluetooth,
    font = { size = 14.0 },
  },
  label = {
    string = "Bluetooth On",
    color = colors.text,
  },
  width = popup_width,
  background = {
    height = 2,
    color = colors.surface1,
    y_offset = -15,
  },
})

-- Device items (created dynamically)
local device_items = {}
for i = 1, max_devices do
  device_items[i] = sbar.add("item", "bluetooth.device." .. i, {
    position = "popup." .. bluetooth.name,
    icon = {
      string = "",
      color = colors.bluetooth,
      font = { size = 12.0 },
      width = 20,
    },
    label = {
      string = "",
      color = colors.text,
      max_chars = 25,
    },
    width = popup_width,
    drawing = false,
  })
end

-- Store device info for click handlers
local device_data = {}
-- Store battery info
local battery_info = {}

-- Get battery info from ioreg (Apple devices) and btmon (GATT devices)
local function update_battery_info(callback)
  battery_info = {}
  local pending = 2

  local function check_done()
    pending = pending - 1
    if pending == 0 then
      callback()
    end
  end

  -- Get Apple device batteries via ioreg
  sbar.exec([[ioreg -r -l -n AppleDeviceManagementHIDEventService 2>/dev/null | grep -E '"Product"|"BatteryPercent"']], function(result)
    if result and result ~= "" then
      local current_product = nil
      for line in tostring(result):gmatch("[^\n]+") do
        local product = line:match('"Product" = "([^"]+)"')
        if product then
          current_product = product
        end
        local battery = line:match('"BatteryPercent" = (%d+)')
        if battery and current_product then
          battery_info[current_product] = tonumber(battery)
          current_product = nil
        end
      end
    end
    check_done()
  end)

  -- Get GATT device batteries via btmon
  sbar.exec(BTMON .. " 2>/dev/null", function(result)
    if result and result ~= "" then
      for line in tostring(result):gmatch("[^\n]+") do
        -- Parse "Adv360 Pro(Home): 89%"
        local name, pct = line:match("([^:]+):%s*(%d+)%%")
        if name and pct then
          battery_info[name:match("^%s*(.-)%s*$")] = tonumber(pct)
        end
      end
    end
    check_done()
  end)
end

-- Find battery for a device name (fuzzy match)
local function get_battery_for_device(name)
  if battery_info[name] then
    return battery_info[name]
  end
  for product, battery in pairs(battery_info) do
    if name:find(product, 1, true) or product:find(name, 1, true) then
      return battery
    end
  end
  return nil
end

local function update_bluetooth()
  sbar.exec(BLUEUTIL .. " --power", function(power)
    if not power or power == "" then
      bluetooth:set({
        icon = { string = icons.bluetooth.off },
        label = { string = "N/A" },
      })
      return
    end

    local is_on = tostring(power):match("1") ~= nil

    if not is_on then
      bluetooth:set({
        icon = { string = icons.bluetooth.off, color = colors.surface1 },
        label = { string = "Off", color = colors.surface1 },
      })
      power_toggle:set({
        icon = { string = icons.bluetooth.off },
        label = { string = "Bluetooth Off" },
      })
      for i = 1, max_devices do
        device_items[i]:set({ drawing = false })
      end
      return
    end

    power_toggle:set({
      icon = { string = icons.bluetooth.on },
      label = { string = "Bluetooth On" },
    })

    update_battery_info(function()
      sbar.exec(BLUEUTIL .. " --paired", function(result)
        if not result or result == "" then
          bluetooth:set({
            icon = { string = icons.bluetooth.on, color = colors.bluetooth },
            label = { string = "On", color = colors.bluetooth },
          })
          return
        end

        local connected_count = 0
        local connected_names = {}
        local devices = {}

        for line in tostring(result):gmatch("[^\n]+") do
          local address = line:match("address: ([^,]+)")
          local name = line:match('name: "([^"]+)"')
          local connected = line:match("connected") and not line:match("not connected")

          if address and name then
            table.insert(devices, {
              address = address,
              name = name,
              connected = connected,
            })
            if connected then
              connected_count = connected_count + 1
              table.insert(connected_names, name)
            end
          end
        end

        if connected_count == 1 then
          local short_name = connected_names[1]:sub(1, 10)
          local battery = get_battery_for_device(connected_names[1])
          local label = short_name
          if battery then
            label = label .. " " .. battery .. "%"
          end
          bluetooth:set({
            icon = { string = icons.bluetooth.connected, color = colors.bluetooth },
            label = { string = label, color = colors.bluetooth },
          })
        elseif connected_count > 1 then
          bluetooth:set({
            icon = { string = icons.bluetooth.connected, color = colors.bluetooth },
            label = { string = connected_count .. " devices", color = colors.bluetooth },
          })
        else
          bluetooth:set({
            icon = { string = icons.bluetooth.on, color = colors.bluetooth },
            label = { string = "On", color = colors.bluetooth },
          })
        end

        device_data = {}
        for i = 1, max_devices do
          if devices[i] then
            local dev = devices[i]
            device_data[i] = dev

            local status_icon = dev.connected and "󰂱" or "󰂲"
            local status_color = dev.connected and colors.green or colors.surface1

            local display_name = dev.name
            if dev.connected then
              local battery = get_battery_for_device(dev.name)
              if battery then
                display_name = dev.name .. " 󰁹" .. battery .. "%"
              end
            end

            device_items[i]:set({
              drawing = true,
              icon = { string = status_icon, color = status_color },
              label = { string = display_name, color = colors.text },
            })
          else
            device_items[i]:set({ drawing = false })
          end
        end
      end)
    end)
  end)
end

bluetooth:subscribe({ "routine", "forced" }, update_bluetooth)

bluetooth:subscribe("mouse.clicked", function()
  local drawing = bluetooth:query().popup.drawing == "on"
  bluetooth:set({ popup = { drawing = not drawing } })
  if not drawing then
    update_bluetooth()
  end
end)

bluetooth:subscribe("mouse.exited.global", function()
  bluetooth:set({ popup = { drawing = false } })
end)

power_toggle:subscribe("mouse.clicked", function()
  sbar.exec(BLUEUTIL .. " --power", function(power)
    local is_on = tostring(power):match("1") ~= nil
    local new_state = is_on and "0" or "1"
    sbar.exec(BLUEUTIL .. " --power " .. new_state, function()
      sbar.delay(1, update_bluetooth)
    end)
  end)
end)

for i = 1, max_devices do
  device_items[i]:subscribe("mouse.clicked", function()
    local dev = device_data[i]
    if dev then
      local cmd = dev.connected and "--disconnect" or "--connect"
      sbar.exec(BLUEUTIL .. " " .. cmd .. ' "' .. dev.address .. '"', function()
        sbar.delay(2, update_bluetooth)
      end)
    end
  end)
end

sbar.add("item", { position = "right", width = settings.group_paddings })
