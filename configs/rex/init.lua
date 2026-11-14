-- Rex configuration (~/.config/rex/init.lua via home-manager).
--
-- Keys follow Rex's own cmd-based defaults instead of a tmux-style prefix, so
-- ctrl+b stays with vim/readline and nothing collides with AeroSpace, which
-- owns ctrl+hjkl, ctrl+shift+hjkl, ctrl+cmd+hjkl, ctrl+1-9 and ctrl+t/a/f.
--
-- Rex defaults kept as is (see `rex keymap` / the command palette):
--   cmd+t new tab, cmd+w close, cmd+1-9 go to tab, shift+cmd+[ ] prev/next tab
--   cmd+d / shift+cmd+d split right/down, shift+cmd+enter zoom
--   cmd+k session picker, shift+cmd+n new session, cmd+p go to anything
--   cmd+f find, cmd+. activity, cmd+/ sidebar, shift+cmd+p command palette
--
-- cmd+h is macOS Hide, so vim-style pane keys live on alt+cmd.

local dirs = { h = "left", j = "down", k = "up", l = "right" }

for key, dir in pairs(dirs) do
  -- Focus and move panes with hjkl (arrows already work via Rex defaults)
  rex.bind("alt+cmd+" .. key, "pane.focus", { direction = dir })
  rex.bind("alt+shift+cmd+" .. key, "pane.move", { direction = dir })
end

-- Sessions (herdr workspaces)
rex.bind("alt+cmd+[", "session.previous")
rex.bind("alt+cmd+]", "session.next")

-- Jump to an agent that is working, waiting or done
rex.bind("alt+cmd+a", "pane.view_activity")

-- Resize mode: alt+cmd+r, then hjkl (shift for bigger steps), = to balance,
-- enter or esc to leave. Exclusive so stray keys don't reach the terminal.
rex.mode("resize", { exclusive = true })
rex.bind("alt+cmd+r", "client.mode.enter", { name = "resize" })
for key, dir in pairs(dirs) do
  rex.bind("resize/" .. key, "pane.resize", { direction = dir })
  rex.bind("resize/shift+" .. key, "pane.resize", { direction = dir, amount = 15 })
end
rex.bind("resize/=", "pane.balance")
rex.bind("resize/enter", "client.mode.exit")

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
rex.bind("alt+cmd+g", "lazygit")

-- Reload this file
rex.bind("shift+cmd+r", "client.config.reload")

-- shift+enter inserts a newline (multi-line input in Claude Code)
rex.bind("shift+enter", "pane.send_key", { key = "ctrl+j" })
