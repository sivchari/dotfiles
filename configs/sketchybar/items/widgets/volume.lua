-- Volume display with popup controls

local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local popup_width = 180

local volume = sbar.add("item", "widgets.volume", {
  position = "right",
  update_freq = settings.update_freq.volume,
  icon = {
    string = icons.volume_high,
    color = colors.volume,
  },
  label = {
    color = colors.volume,
    width = 35,
    align = "right",
  },
  padding_left = 5,
  padding_right = 5,
  popup = {
    height = 35,
  },
})

sbar.add("bracket", "widgets.volume.bracket", { volume.name }, {
  background = { color = colors.item_bg, border_color = colors.volume, border_width = 2 },
})

-- Mute toggle in popup
local mute_toggle = sbar.add("item", "volume.mute", {
  position = "popup." .. volume.name,
  icon = {
    string = icons.volume_high,
    color = colors.volume,
    font = { size = 16.0 },
    width = 30,
  },
  label = {
    string = "Unmuted",
    color = colors.text,
  },
  width = popup_width,
  background = {
    height = 2,
    color = colors.surface1,
    y_offset = -15,
  },
})

-- Volume control buttons
local volume_down = sbar.add("item", "volume.down", {
  position = "popup." .. volume.name,
  icon = {
    string = "󰝞",
    color = colors.volume,
    font = { size = 18.0 },
  },
  label = {
    string = "-10",
    color = colors.subtext0,
    font = { size = 10.0 },
  },
  width = popup_width / 2,
  background = {
    color = colors.surface0,
    corner_radius = 5,
    height = 28,
  },
})

local volume_up = sbar.add("item", "volume.up", {
  position = "popup." .. volume.name,
  icon = {
    string = "󰝝",
    color = colors.volume,
    font = { size = 18.0 },
  },
  label = {
    string = "+10",
    color = colors.subtext0,
    font = { size = 10.0 },
  },
  width = popup_width / 2,
  background = {
    color = colors.surface0,
    corner_radius = 5,
    height = 28,
  },
})

local current_volume = 0
local is_muted = false

local function update_volume()
  sbar.exec("osascript -e 'output volume of (get volume settings)'", function(vol)
    local volume_val = tonumber(vol)
    if not volume_val then
      volume:set({ label = { string = "N/A" } })
      return
    end

    current_volume = volume_val

    local icon = icons.volume_high
    if volume_val == 0 then
      icon = icons.volume_mute
    elseif volume_val <= 30 then
      icon = icons.volume_low
    elseif volume_val <= 60 then
      icon = icons.volume_medium
    end

    sbar.exec("osascript -e 'output muted of (get volume settings)'", function(muted)
      is_muted = muted:match("true") ~= nil

      if is_muted then
        volume:set({
          icon = { string = icons.volume_mute, color = colors.surface1 },
          label = { string = "Mute", color = colors.surface1 },
        })
        mute_toggle:set({
          icon = { string = icons.volume_mute, color = colors.surface1 },
          label = { string = "Muted" },
        })
      else
        volume:set({
          icon = { string = icon, color = colors.volume },
          label = { string = volume_val .. "%", color = colors.volume },
        })
        mute_toggle:set({
          icon = { string = icon, color = colors.volume },
          label = { string = volume_val .. "%" },
        })
      end
    end)
  end)
end

-- Set volume helper
local function set_volume(val)
  if val < 0 then val = 0 end
  if val > 100 then val = 100 end
  sbar.exec("osascript -e 'set volume output volume " .. val .. "'", function()
    sbar.delay(0.1, update_volume)
  end)
end

-- Toggle mute
local function toggle_mute()
  local cmd = is_muted and "set volume without output muted" or "set volume with output muted"
  sbar.exec("osascript -e '" .. cmd .. "'", function()
    sbar.delay(0.1, update_volume)
  end)
end

-- Event handlers
volume:subscribe({ "routine", "forced", "volume_change" }, update_volume)

-- Toggle popup
volume:subscribe("mouse.clicked", function()
  local drawing = volume:query().popup.drawing == "on"
  volume:set({ popup = { drawing = not drawing } })
  if not drawing then
    update_volume()
  end
end)

volume:subscribe("mouse.exited.global", function()
  volume:set({ popup = { drawing = false } })
end)

-- Scroll to adjust volume
volume:subscribe("mouse.scrolled", function(env)
  local delta = tonumber(env.SCROLL_DELTA) or 0
  set_volume(current_volume + delta * 5)
end)

-- Mute toggle click
mute_toggle:subscribe("mouse.clicked", toggle_mute)

-- Volume buttons
volume_down:subscribe("mouse.clicked", function()
  set_volume(current_volume - 10)
end)

volume_up:subscribe("mouse.clicked", function()
  set_volume(current_volume + 10)
end)

sbar.add("item", { position = "right", width = settings.group_paddings })
