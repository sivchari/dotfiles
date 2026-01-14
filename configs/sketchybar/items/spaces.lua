-- AeroSpace workspaces

local colors = require("colors")
local settings = require("settings")

local workspaces = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" }
local spaces = {}

-- Add custom event for aerospace
sbar.add("event", "aerospace_workspace_change")

local function trim(value)
  return (value or ""):gsub("%s+", "")
end

local function apply_space_styles(focused_workspace)
  for _, sid in ipairs(workspaces) do
    local focused = focused_workspace == sid
    local bg_color = colors.surface0
    local icon_color = colors.overlay0

    if focused then
      bg_color = colors.spaces
      icon_color = colors.crust
    end

    spaces[sid]:set({
      icon = { color = icon_color },
      background = { color = bg_color },
    })
  end
end

local function request_space_update(focused_workspace)
  apply_space_styles(trim(focused_workspace))
end

-- Create workspace items
for _, sid in ipairs(workspaces) do
  local space = sbar.add("item", "space." .. sid, {
    position = "left",
    icon = {
      string = sid,
      font = {
        family = settings.font.text,
        style = settings.font.style_map["Bold"],
        size = 12.0,
      },
      color = colors.overlay0,
      padding_left = 10,
      padding_right = 10,
    },
    label = { drawing = false },
    background = {
      color = colors.surface0,
      corner_radius = 5,
      height = 20,
      border_width = 0,
    },
    padding_left = 2,
    padding_right = 2,
  })

  space:subscribe("mouse.clicked", function()
    sbar.exec("aerospace workspace " .. sid)
  end)

  spaces[sid] = space
end

local space_observer = sbar.add("item", "space.observer", {
  drawing = false,
  updates = true,
})

space_observer:subscribe("aerospace_workspace_change", function(env)
  request_space_update(env.FOCUSED_WORKSPACE)
end)

-- Bracket for workspaces
local spaces_bracket = sbar.add("bracket", "spaces", { "/space\\..*/" }, {
  background = {
    color = colors.item_bg,
    border_color = colors.spaces,
    border_width = 2,
    corner_radius = 10,
    height = 24,
  },
})

-- Initial state: trigger update on startup
sbar.exec("aerospace list-workspaces --focused --format '%{workspace}'", function(focused_workspace)
  request_space_update(focused_workspace)
end)

-- Separator
sbar.add("item", "sep_left", {
  position = "left",
  icon = {
    string = "",
    font = { size = 14.0 },
    color = colors.overlay0,
    padding_left = 8,
    padding_right = 4,
  },
  label = { drawing = false },
  background = { drawing = false },
})
