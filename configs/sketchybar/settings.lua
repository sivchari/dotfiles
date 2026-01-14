-- Global settings

local M = {}

-- Paddings
M.paddings = 4
M.group_paddings = 2

-- Font settings
M.font = {
  text = "Hack Nerd Font",
  numbers = "Hack Nerd Font",
  style_map = {
    ["Regular"] = "Regular",
    ["Semibold"] = "Bold",
    ["Bold"] = "Bold",
    ["Heavy"] = "Bold",
  },
}

-- Update frequencies (seconds)
M.update_freq = {
  datetime  = 10,
  battery   = 60,
  volume    = 10,
  wifi      = 30,
  bluetooth = 30,
  cpu       = 5,
  memory    = 10,
  disk      = 300,
  keyboard  = 120,
}

return M
