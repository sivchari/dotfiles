-- SketchyBar Lua configuration
-- Initialize SbarLua module path

package.cpath = package.cpath .. ";/Users/" .. os.getenv("USER") .. "/.local/share/sketchybar_lua/?.so"

sbar = require("sketchybar")

sbar.begin_config()

require("bar")
require("default")
require("items")

sbar.end_config()

-- Event loop for callbacks
sbar.event_loop()
