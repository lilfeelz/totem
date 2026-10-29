# Local firmware build in an isolated west workspace, as CI does (zmk-build.yml).
# One-time setup: README "Local build".
W ?= $(HOME)/.cache/zmk-totem
export ZEPHYR_SDK_INSTALL_DIR ?= $(HOME)/zephyr-sdk-0.17.0
export ZEPHYR_TOOLCHAIN_VARIANT = zephyr
SHIELDS = totem_left totem_right settings_reset

.PHONY: all update validate clean $(SHIELDS)
all: $(SHIELDS)

# Re-sync config and fetch ZMK at the pinned revision.
update:
	@mkdir -p $(W)
	rm -rf $(W)/config && cp -R config $(W)/config
	@[ -d $(W)/.west ] || west init -l --mr HEAD $(W)/config
	cd $(W) && west update --fetch-opt=--filter=tree:0 && west zephyr-export

$(SHIELDS):
	rm -rf $(W)/config && cp -R config $(W)/config
	cd $(W) && west build -s zmk/app -d build/$@ -b xiao_ble//zmk -- \
	  -DZMK_CONFIG=$(W)/config -DSHIELD=$@ -DZMK_EXTRA_MODULES=$(CURDIR)
	@mkdir -p build && cp $(W)/build/$@/zephyr/zmk.uf2 build/$@.uf2

validate:
	uvx --from keymap-drawer keymap parse -z config/totem.keymap -o /dev/null

clean:
	rm -rf build $(W)/build
