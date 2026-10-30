# meta-st-stm32mp-addons

## Per-panel devicetrees

Each Cargt board has a board-wide devicetree and per-panel variants named
`<board dtb>-gltNNN...` (for example
`stm32mp257f-cargt-00395-01-00365-glt0557201280is1`). Each one is listed in
`STM32MP_DT_FILES_EMMC` and `STM32MP_DT_FILES_SDCARD`, and gets its own FIP
and FlashLayout.

A per-panel devicetree must have, in both its U-Boot and kernel `.dts`:

```
compatible = "cargt,<dtb basename>", "cargt,<board dtb basename>", "st,stm32mp257";
```

The first entry must be exactly the DTB file name without `.dtb`. Other
layers depend on this:

- meta-st-cargt U-Boot patch 0009 sets `fdtfile=<dtb basename>.dtb` from it
  when the second entry is also `cargt,`, so Linux boots the devicetree that
  matches the running FIP.
- meta-st-cargt's RAUC FIP install hook reads it from
  `/proc/device-tree/compatible` to pick `fip-<dtb basename>-optee-emmc.bin`
  from the update bundle.

The board-wide devicetree has just `"cargt,<board dtb basename>"` and
`"st,stm32mp257"`, so U-Boot leaves its saved `fdtfile` alone.
