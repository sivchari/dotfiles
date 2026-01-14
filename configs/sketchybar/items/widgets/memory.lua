-- Memory usage display

local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local memory = sbar.add("item", "widgets.memory", {
  position = "right",
  update_freq = settings.update_freq.memory,
  icon = {
    string = icons.memory,
    color = colors.memory,
  },
  label = {
    string = "??/??G",
    color = colors.memory,
    font = { family = settings.font.numbers },
    align = "right",
  },
  padding_right = 0,
  padding_left = 5,
})

sbar.add("bracket", "widgets.memory.bracket", { memory.name }, {
  background = { color = colors.item_bg, border_color = colors.memory, border_width = 2 },
})

memory:subscribe({ "routine", "forced" }, function()
  sbar.exec([[
    pages_active=$(vm_stat | grep "Pages active" | awk '{print $3}' | tr -d '.')
    pages_wired=$(vm_stat | grep "Pages wired" | awk '{print $4}' | tr -d '.')
    pages_compressed=$(vm_stat | grep "Pages occupied by compressor" | awk '{print $5}' | tr -d '.')

    used_pages=$((pages_active + pages_wired + pages_compressed))
    used_gb=$(echo "scale=1; $used_pages * 4096 / 1024 / 1024 / 1024" | bc)

    total_gb=$(sysctl -n hw.memsize | awk '{print $1 / 1024 / 1024 / 1024}')
    total_gb_int=$(printf "%.0f" $total_gb)

    echo "${used_gb}/${total_gb_int}G"
  ]], function(result)
    local mem = result:gsub("\n", "")
    if mem == "" then
      memory:set({ label = { string = "N/A" } })
    else
      memory:set({ label = { string = mem } })
    end
  end)
end)

sbar.add("item", { position = "right", width = settings.group_paddings })
