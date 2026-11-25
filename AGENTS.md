# ZMK: TOTEM Firmware

ZMK user config for TOTEM 38-key split keyboard on Seeed XIAO BLE (nRF52840).

Edit `config/totem.keymap`; the root keymap overrides the shield built-in.
Matrix: 38 keys (rows 0-1: 10 cols, row 2: 12 with outer pinkies, row 3: 6 thumbs).
Outer pinkies (positions 20, 31) are wired on electrical row 3 (`RC(3,0)`, `RC(3,9)`).
Hold-tap defaults live in `&mt {};` and `&lt {};`, custom behaviors in `/behaviors {};`.

## Structure

- `config/totem.keymap`: root keymap (source of truth)
- `config/totem.conf`: board-level config (sleep, idle, BT)
- `config/west.yml`: west manifest (ZMK revision, pinned to a main commit)
- `config/info.json`: layout metadata (keymap-drawer TOTEM geometry)
- `config/boards/shields/totem/`: shield definitions (`totem_left.overlay`, `totem_right.overlay`, `totem.dtsi`)

## Layers

Layer table, thumb bindings and combos live in `docs/totem/keymap.md` (published by CI).
Update it in the same commit as any layer, thumb or combo change to `config/totem.keymap`.
Do not repeat the table here.

## Custom Behaviors

- **Hold-taps**: stock `&mt` (150ms) on BASE pos 19, NAV and SYM home rows; stock `&lt` (150ms) on outer pinkies (`&lt FUN CAPSLOCK`, pos 20, 31), left middle thumb (`&lt 1 BACKSPACE`, pos 33), and right middle thumb (`&lt 2 ESCAPE`, pos 36).
- **Mod-morphs (6)**: `comma_semicolon`, `period_colon`, `cmd_tab` (TAB -> F21 with GUI), `cmd_stb` (LS(TAB) -> F22 with GUI), `bwd_dwd`, `caps` (caps_word -> CAPSLOCK with shift).
- **Combos (5)**: `enter` (16 17), `bs_df` (12 13), `caps_word` (32 37, outer thumbs) on BASE; `cmd_shift_nav` (12 13, NAV) and `cmd_shift_sym` (16 17, SYM) hold Cmd+Shift. See `docs/totem/keymap.md#combos`.
- **Macro**: `cmd_shift` presses LSHIFT+LGUI until release, the pair's Cmd+Shift.

## Commands

```sh
make validate     # parse config/totem.keymap with keymap-drawer
make              # build build/{totem_left,totem_right,settings_reset}.uf2
make totem_left   # build one shield
make update       # re-sync config, fetch ZMK at west.yml revision
make clean        # remove build/ and ~/.cache/zmk-totem/build
```

Isolated west workspace lives at `~/.cache/zmk-totem` with Zephyr SDK 0.17.0 at `~/zephyr-sdk-0.17.0`. First-time setup: README "Build".
CI builds firmware (`.github/workflows/zmk-build.yml`) and renders the SVG + HonKit site (`.github/workflows/zmk-docs.yml`).

## Layout Counterparts

The same layout is mirrored in a kanata configuration for macOS. Apply layout changes in
both places, or explain any copy left behind. No release-please or changelog bumps.
