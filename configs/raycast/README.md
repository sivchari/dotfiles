# Raycast

Raycast の設定は 3 層で管理する。完全な宣言管理は不可能 (設定本体は暗号化 DB) なので、
層ごとに割り切る。

1. **宣言 (nix)**: 本体のインストール、Spotlight Cmd+Space の無効化、`scripts/` の配布
   (`~/.config/raycast/scripts`)。rebuild で反映される
2. **半自動 (`make raycast-import`)**: `snippets.json` を source of truth として deeplink で
   import。Raycast は同一 snippet を skip するので再実行は冪等
3. **.rayconfig (`make raycast-backup`)**: extensions・alias/hotkey・拡張設定は export/import
   でしか持ち運べない。export 時は passphrase を空、clipboard history を除外にする

手動のまま残すもの (新マシン 1 回): 初回ログイン、hotkey を Cmd+Space に設定、Accessibility
権限付与、Settings → Extensions での `~/.config/raycast/scripts` 登録、.rayconfig の import。

注意: nixpkgs 版 Raycast は更新で store path が変わると Accessibility 権限が剥がれることが
ある。その場合は System Settings で付与し直す。
