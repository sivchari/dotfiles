# Raycast

Raycast is managed in three layers. Full declarative management is impossible
(the settings live in an encrypted DB), so each layer uses the strongest
mechanism it supports.

1. **Declarative (nix)**: installing Raycast, disabling Spotlight's Cmd+Space,
   and distributing `scripts/` to `~/.config/raycast/scripts`. Applied on
   rebuild
2. **Semi-automatic (`make raycast-import`)**: `snippets.json` is the source of
   truth, imported via deeplink. Raycast skips identical snippets, so re-running
   is idempotent
3. **.rayconfig (`make raycast-backup`)**: extensions, aliases/hotkeys, and
   extension preferences can only travel via export/import. Export with an
   empty passphrase and clipboard history excluded

Still manual (once per new machine): first login, assigning Cmd+Space as the
hotkey, granting Accessibility permission, registering
`~/.config/raycast/scripts` under Settings -> Extensions, and importing the
.rayconfig.

Note: the nixpkgs build of Raycast can lose its Accessibility permission when
an update changes the store path. Re-grant it in System Settings if that
happens.
