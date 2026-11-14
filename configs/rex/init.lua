-- Rex configuration (~/.config/rex/init.lua via home-manager).
--
-- Written for an Advantage360 Pro: cmd, alt and shift sit only on the left,
-- ctrl only on the right, and [ ] need the fn layer. So instead of stacking
-- modifiers, everything hangs off one leader, cmd+j (left thumb + right
-- index), followed by a single key, laid out like the old herdr prefix.
-- cmd never reaches the terminal, so ctrl+b stays with vim/readline, and
-- nothing collides with AeroSpace's ctrl bindings.
--
-- Rex defaults kept as is (see `rex keymap` / the command palette):
--   cmd+t new tab, cmd+w close, cmd+1-9 go to tab, cmd+d / shift+cmd+d split
--   cmd+k session picker, shift+cmd+n new session, cmd+p go to anything
--   cmd+f find, cmd+. activity, cmd+/ sidebar, shift+cmd+p command palette

local leader = "cmd+j>"
local dirs = { h = "left", j = "down", k = "up", l = "right" }

local function lead(key, action, args)
  rex.bind(leader .. key, action, args)
end

-- Panes
for key, dir in pairs(dirs) do
  lead(key, "pane.focus", { direction = dir })
end
lead("-", "pane.split", { direction = "down" })
lead("v", "pane.split", { direction = "right" })
lead("x", "pane.close")
lead("z", "pane.zoom")
lead("=", "pane.balance")

-- Tabs
lead("c", "client.tab.new")
lead("n", "client.tab.next")
lead("p", "client.tab.previous")
lead("shift+x", "client.tab.close")
lead(",", "client.tab.rename")
for i = 1, 9 do
  lead(tostring(i), "client.tab.goto", { index = i })
end

-- Sessions (herdr workspaces)
lead("shift+h", "session.previous")
lead("shift+l", "session.next")
lead("s", "session.switch")

-- Jump to an agent that is working, waiting or done
lead("a", "pane.view_activity")

-- Modes: leader then r (resize) or m (move), hjkl inside, enter or esc to
-- leave. Exclusive so stray keys don't reach the terminal.
rex.mode("resize", { exclusive = true })
lead("r", "client.mode.enter", { name = "resize" })
for key, dir in pairs(dirs) do
  rex.bind("resize/" .. key, "pane.resize", { direction = dir })
  rex.bind("resize/shift+" .. key, "pane.resize", { direction = dir, amount = 15 })
end
rex.bind("resize/=", "pane.balance")
rex.bind("resize/enter", "client.mode.exit")

rex.mode("move", { exclusive = true })
lead("m", "client.mode.enter", { name = "move" })
for key, dir in pairs(dirs) do
  rex.bind("move/" .. key, "pane.move", { direction = dir })
end
rex.bind("move/enter", "client.mode.exit")

-- lazygit in a floating pane, in the focused terminal's directory.
-- Closes with lazygit (q).
local terminal = "com.superlogical.terminal"

local function focused_cwd()
  local proc = rex.block.call(terminal, "process", {})
  if proc then
    local p = proc.foreground or proc.child
    if p and p.cwd then
      return p.cwd
    end
  end
  local pwd = rex.block.call(terminal, "pwd", {})
  return pwd and pwd.pwd or nil
end

rex.action{
  name = "lazygit",
  title = "Open lazygit",
  keywords = "git floating",
  run = function(ctx, args)
    local _, err = rex.session.new_layer{
      bounds = { 0.05, 0.05, 0.9, 0.9 },
      focus = true,
      layout = rex.layout.block{
        flavor = "com.superlogical.terminal.shell",
        options = { command = { "lazygit" }, cwd = focused_cwd() },
      },
    }
    if err then
      rex.log("error", "lazygit: " .. tostring(err))
    end
  end,
}
lead("g", "lazygit")

-- Reload this file
lead("shift+r", "client.config.reload")

-- shift+enter inserts a newline (multi-line input in Claude Code)
rex.bind("shift+enter", "pane.send_key", { key = "ctrl+j" })
