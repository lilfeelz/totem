---
name: keymap-validation
description: Validate ZMK keymap with keymap-drawer using make validate or parse/draw.
---

# Keymap Validation

```sh
make validate
# or with keymap-drawer installed locally:
keymap -c keymap_drawer.config.yaml parse -z config/totem.keymap -o /tmp/keymap.yaml
keymap -c keymap_drawer.config.yaml draw /tmp/keymap.yaml -o docs/totem/images/keymap.svg
```

Exit 0 means valid. Global `-c keymap_drawer.config.yaml` must precede `parse`/`draw`.
Common errors: missing `#binding-cells`, wrong binding count per row, undefined combos/behaviors, nested `()` in key positions.
`.github/workflows/zmk-docs.yml` runs the same commands on deploy.
