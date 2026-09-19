#!/bin/bash
# LinkiGSI rebrand - патчит распакованный GSI
set -e
GSI_DIR=${1:-./unpacked}
patch_prop() {
  f="$1"
  [ -f "$f" ] || return 0
  echo "-> $f"
  for k in ro.product.system.brand ro.product.system.manufacturer ro.product.system.model ro.product.system.device ro.product.system.name ro.product.product.brand ro.product.product.model ro.product.product.device ro.build.display.id ro.modversion ro.custom.rom; do
    sed -i "/^$k=/d" "$f"
  done
  cat "$(dirname $0)/LinkiGSI.prop" >> "$f"
}
patch_prop "$GSI_DIR/system/build.prop"
patch_prop "$GSI_DIR/system_ext/build.prop"
patch_prop "$GSI_DIR/product/build.prop"
patch_prop "$GSI_DIR/product/etc/build.prop"
echo "LinkiGSI OK"
grep -h "LinkiGSI" "$GSI_DIR/system/build.prop" || true
