-- AeroSpace workspaces

local colors = require("colors")
local settings = require("settings")

local workspaces = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" }

-- Add custom event for aerospace
sbar.add("event", "aerospace_workspace_change")

-- Create workspace items
local spaces = {}
for i, sid in ipairs(workspaces) do
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

  space:subscribe("aerospace_workspace_change", function(env)
    local focused = env.FOCUSED_WORKSPACE == sid
    local has_windows = false

    -- Check if workspace has windows
    sbar.exec("aerospace list-windows --workspace " .. sid .. " --count", function(result)
      local count = tonumber(result) or 0
      has_windows = count > 0

      local bg_color = colors.surface0
      local icon_color = colors.overlay0

      if focused then
        bg_color = colors.spaces
        icon_color = colors.crust
      elseif has_windows then
        bg_color = colors.surface1
        icon_color = colors.text
      end

      space:set({
        icon = { color = icon_color },
        background = { color = bg_color },
      })
    end)
  end)

  spaces[i] = space
end

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
sbar.exec("aerospace list-workspaces --focused", function(focused_workspace)
  focused_workspace = focused_workspace:gsub("%s+", "") -- trim whitespace
  sbar.trigger("aerospace_workspace_change", { FOCUSED_WORKSPACE = focused_workspace })
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
