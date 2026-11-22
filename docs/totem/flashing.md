# Building & Flashing

## Local Build

```sh
make              # writes build/{totem_left,totem_right,settings_reset}.uf2
make totem_left   # build one shield
```

First-time ZMK SDK setup is in `README.md`.

## GitHub Actions

CI builds in an isolated west workspace on push to `main`. Firmware artifacts live under [Actions](https://github.com/lilfeelz/totem/actions/workflows/zmk-build.yml).

## Flashing

1. Enter bootloader (double-tap reset on XIAO BLE)
2. Copy the `.uf2` file to the mounted mass-storage device
3. Device resets automatically; flash left half first and label controllers before soldering
