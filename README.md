[![Build](https://github.com/lilfeelz/totem/actions/workflows/zmk-build.yml/badge.svg)](https://github.com/lilfeelz/totem/actions/workflows/zmk-build.yml)
[![Docs](https://github.com/lilfeelz/totem/actions/workflows/zmk-docs.yml/badge.svg)](https://docs.lilfeelz.org/totem/)
[![GH Pages](https://img.shields.io/badge/docs-docs.lilfeelz.org/totem-9ee7ff?logo=github&labelColor=0b0d10)](https://docs.lilfeelz.org/totem/)

# TOTEM ZMK Configuration

38-key split column-staggered keyboard firmware for the [TOTEM](https://github.com/GEIGEIGEIST/TOTEM), powered by Seeed XIAO BLE (nRF52840). Built with ZMK.

## Quickstart

Edit `config/totem.keymap` (root keymap overrides the shield built-in), then validate:

```sh
make validate
```

CI builds on push (`zmk-build.yml`) and publishes docs (`zmk-docs.yml`). Locally, one-time setup:

```sh
brew install cmake ninja dtc gperf ccache
uv tool install west
# Zephyr SDK 0.17.0 (arm-zephyr-eabi) from github.com/zephyrproject-rtos/sdk-ng/releases
# extracted to ~/zephyr-sdk-0.17.0 (west sdk install does not work with CMake 4)
make update
uv tool install west --force --with-requirements ~/.cache/zmk-totem/zephyr/scripts/requirements-base.txt
```

### Build

`make` writes `build/{totem_left,totem_right,settings_reset}.uf2`; `make totem_left` builds one shield, `make clean` clears build outputs. The west workspace lives in `~/.cache/zmk-totem` outside the repo because this repo is itself a Zephyr module.

### Docs preview

```sh
npm install honkit
npx honkit serve docs  # http://localhost:4000
```

## Layout

Four layers (BASE, NAV, SYM, FUN). Matrix positions, layer tables, thumb bindings and combos live in [`docs/totem/keymap.md`](docs/totem/keymap.md) and at [docs.lilfeelz.org/totem](https://docs.lilfeelz.org/totem/).

## Build Targets

| Shield | Board |
|---|---|
| `totem_left` | `xiao_ble//zmk` |
| `totem_right` | `xiao_ble//zmk` |
| `settings_reset` | `xiao_ble//zmk` |

## Structure

- `config/totem.keymap`: root keymap (source of truth)
- `config/totem.conf`: board config (sleep, BT, idle)
- `config/west.yml`: west manifest (ZMK pinned to a main commit)
- `config/boards/shields/totem/`: shield definition (dtsi, overlay, Kconfig)
- `build.yaml`: CI build matrix
- `docs/`: HonKit documentation site
- `keymap_drawer.config.yaml`: SVG rendering config

## Layout Counterparts

Keep layer, thumb, hold and chord changes aligned with `lilfeelz/.config/home/dot_config/kanata/kanata.kbd` and [JakobMelchard/apple](https://github.com/JakobMelchard/apple/tree/main/kanata-ios) (`kanata-ios/`).
