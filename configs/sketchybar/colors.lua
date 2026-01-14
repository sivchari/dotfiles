-- Catppuccin Mocha color palette
-- https://github.com/catppuccin/catppuccin

local M = {}

-- Base colors
M.base      = 0xff1e1e2e
M.mantle    = 0xff181825
M.crust     = 0xff11111b
M.surface0  = 0xff313244
M.surface1  = 0xff45475a
M.surface2  = 0xff585b70
M.overlay0  = 0xff6c7086
M.overlay1  = 0xff7f849c
M.overlay2  = 0xff9399b2
M.subtext0  = 0xffa6adc8
M.subtext1  = 0xffbac2de
M.text      = 0xffcdd6f4

-- Accent colors
M.rosewater = 0xfff5e0dc
M.flamingo  = 0xfff2cdcd
M.pink      = 0xfff5c2e7
M.mauve     = 0xffcba6f7
M.red       = 0xfff38ba8
M.maroon    = 0xffeba0ac
M.peach     = 0xfffab387
M.yellow    = 0xfff9e2af
M.green     = 0xffa6e3a1
M.teal      = 0xff94e2d5
M.sky       = 0xff89dceb
M.sapphire  = 0xff74c7ec
M.blue      = 0xff89b4fa
M.lavender  = 0xffb4befe

-- Semantic colors (for sketchybar items)
M.bar_bg        = 0xf01e1e2e  -- with transparency
M.item_bg       = 0x65313244  -- with transparency
M.popup_bg      = 0xff1e1e2e
M.popup_border  = 0xffcba6f7

-- Item-specific colors
M.apple      = M.mauve     -- Apple logo
M.spaces     = M.blue      -- AeroSpace workspaces
M.front_app  = M.peach     -- Front app name
M.datetime   = M.lavender  -- Date and time
M.battery    = M.yellow    -- Battery
M.volume     = M.sapphire  -- Volume
M.wifi       = M.sky       -- WiFi
M.wifi_up    = M.red       -- WiFi upload
M.wifi_down  = M.sky       -- WiFi download
M.bluetooth  = M.mauve     -- Bluetooth
M.cpu        = M.green     -- CPU
M.memory     = M.peach     -- Memory
M.disk       = M.pink      -- Disk
M.keyboard   = M.teal      -- Keyboard battery

-- Utility function: apply alpha to color
function M.with_alpha(color, alpha)
  if alpha > 1.0 or alpha < 0.0 then
    return color
  end
  local alpha_hex = math.floor(alpha * 255)
  return (color & 0x00ffffff) | (alpha_hex << 24)
end

return M
