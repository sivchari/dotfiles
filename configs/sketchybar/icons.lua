-- Nerd Font icons
-- https://www.nerdfonts.com/cheat-sheet

local M = {}

-- System
M.apple         = ""  -- nf-fa-apple
M.lock          = ""  -- nf-fa-lock
M.sleep         = "󰒲"  -- nf-md-sleep
M.restart       = ""  -- nf-fa-refresh
M.shutdown      = ""  -- nf-fa-power_off

-- Navigation
M.chevron_right = ""  -- nf-fa-chevron_right

-- Date/Time
M.calendar      = ""  -- nf-fa-calendar

-- Power
M.battery_full  = ""  -- nf-fa-battery_full
M.battery_three = ""  -- nf-fa-battery_three_quarters
M.battery_half  = ""  -- nf-fa-battery_half
M.battery_one   = ""  -- nf-fa-battery_quarter
M.battery_empty = ""  -- nf-fa-battery_empty
M.charging      = ""  -- nf-fa-bolt

-- Audio
M.volume_high   = ""  -- nf-fa-volume_up
M.volume_medium = ""  -- nf-fa-volume_down
M.volume_low    = ""  -- nf-fa-volume_off
M.volume_mute   = "󰖁"  -- nf-md-volume_mute

-- Network
M.wifi = {
  connected     = "󰖩",  -- nf-md-wifi
  disconnected  = "󰖪",  -- nf-md-wifi_off
  upload        = "",  -- nf-fa-arrow_up
  download      = "",  -- nf-fa-arrow_down
  router        = "󰑩",  -- nf-md-router_wireless
}

-- Bluetooth
M.bluetooth = {
  on            = "",  -- nf-fa-bluetooth_b
  off           = "󰂲",  -- nf-md-bluetooth_off
  connected     = "󰂱",  -- nf-md-bluetooth_connect
}

-- Hardware
M.cpu           = "󰻠"  -- nf-md-cpu_64_bit
M.memory        = "󰍛"  -- nf-md-memory
M.disk          = "󰋊"  -- nf-md-harddisk

-- Misc
M.clipboard     = "󰅍"  -- nf-md-clipboard

-- Keyboard
M.keyboard      = "󰌌"  -- nf-md-keyboard

return M
