-- Helpers initialization
-- Build helpers if needed

local helpers_dir = os.getenv("HOME") .. "/.config/sketchybar/helpers"

-- Ensure helpers are built
os.execute("cd " .. helpers_dir .. " && make >/dev/null 2>&1")
