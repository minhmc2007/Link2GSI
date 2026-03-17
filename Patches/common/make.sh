#!/bin/bash

BASE_DIR="$1"
SCRIPT_DIR=$(dirname "$0")
TEMP_DIR="$SCRIPT_DIR/../../Temp"

# Detecta diretórios product
if [ -d "$BASE_DIR/product" ] && [ ! -L "$BASE_DIR/product" ]; then
    product="$BASE_DIR/product"
elif [ -d "$BASE_DIR/system/product" ] && [ ! -L "$BASE_DIR/system/product" ]; then
    product="$BASE_DIR/system/product"
else
    echo "error: No product dir"
    exit 1
fi

# Detecta diretórios system_ext
if [ -d "$BASE_DIR/system_ext" ] && [ ! -L "$BASE_DIR/system_ext" ]; then
    system_ext="$BASE_DIR/system_ext"
elif [ -d "$BASE_DIR/system/system_ext" ] && [ ! -L "$BASE_DIR/system/system_ext" ]; then
    system_ext="$BASE_DIR/system/system_ext"
else
    echo "error: No system_ext dir"
    exit 1
fi

echo "==> Aplicando PHH patches..."
rsync -ra "$SCRIPT_DIR/system/" "$BASE_DIR/system/"
rsync -ra "$SCRIPT_DIR/system_ext/" "$system_ext/"

echo "==> Aplicando overlays..."
mkdir -p "$product/overlay"
rsync -ra "$SCRIPT_DIR/overlay/" "$product/overlay/"

echo "==> Limpando build.prop..."
for prop in ro.secure ro.adb.secure ro.debuggable ro.force.debuggable media.settings.xml ro.arch persist.sys.usb.config ro.actionable_compatible_property.enabled ro.setupwizard.mode ro.product.ab_ota_partitions; do
    sed -i "/$prop/d" "$BASE_DIR/system/build.prop"
    sed -i "/$prop/d" "$product/etc/build.prop"
done

cat "$SCRIPT_DIR/system_build.prop" >> "$BASE_DIR/system/build.prop"
cat "$SCRIPT_DIR/product_build.prop" >> "$product/etc/build.prop"
cat "$SCRIPT_DIR/file_contexts" >> "$BASE_DIR/system/etc/selinux/plat_file_contexts"

echo "==> Removendo blobs indesejados..."
rm -rf $BASE_DIR/system/lib64/libdolphin.so
rm -rf $system_ext/lib64/libdolphin.so
rm -rf $system_ext/etc/permissions/qti_permissions.xml
rm -rf $system_ext/etc/permissions/com.qti.dpmframework.xml
rm -rf $system_ext/app/QCC $system_ext/app/QColor $system_ext/app/QesdkSysService
rm -rf $system_ext/priv-app/com.qualcomm.qti.services.systemhelper
rm -rf $system_ext/priv-app/com.qualcomm.location
rm -rf $system_ext/priv-app/qcrilmsgtunnel
rm -rf $system_ext/priv-app/QtiWifiService
rm -rf $system_ext/priv-app/dpmserviceapp
rm -rf $BASE_DIR/system/priv-app/DiracAudioControlService
rm -rf $BASE_DIR/system/app/DiracManager

echo "==> Ajustando bluetooth..."
if [ -f "$BASE_DIR/system/lib64/libbluetooth_qti.so" ]; then
    echo "ro.bluetooth.library_name=libbluetooth_qti.so" >> "$BASE_DIR/system/build.prop"
fi
if [ -f "$system_ext/lib64/libbluetooth_qti.so" ]; then
    echo "ro.bluetooth.library_name=libbluetooth_qti.so" >> "$system_ext/etc/build.prop"
fi

echo "==> Limpando SELinux..."
$SCRIPT_DIR/../../Tools/sepolicy/sepolicy_prop_remover.sh \
    $BASE_DIR/system/etc/selinux/plat_property_contexts "device/qcom/sepolicy" > $TEMP_DIR/plat_property_contexts
mv $TEMP_DIR/plat_property_contexts $BASE_DIR/system/etc/selinux/plat_property_contexts
sed -i "/typetransition location_app/d" $BASE_DIR/system/etc/selinux/plat_sepolicy.cil

# Remove propriedades problemáticas
for ctx in $BASE_DIR/system/etc/selinux/plat_property_contexts \
           $system_ext/etc/selinux/system_ext_property_contexts; do
    sed -i "/persist.vendor.camera/d" $ctx
    sed -i "/ro.vendor.camera/d" $ctx
    sed -i "/vendor.camera/d" $ctx
done

sed -i "/persist.vendor.camera/d" $system_ext/etc/selinux/system_ext_sepolicy.cil
sed -i "/ro.vendor.camera/d" $system_ext/etc/selinux/system_ext_sepolicy.cil
sed -i "/vendor.camera/d" $system_ext/etc/selinux/system_ext_sepolicy.cil
sed -i "/genfscon/d" $system_ext/etc/selinux/system_ext_sepolicy.cil

rm -rf $system_ext/etc/selinux/mapping/*
rm -rf $product/etc/selinux/mapping/*

echo "==> Removendo update_engine e OTA..."
rm -rf $BASE_DIR/system/bin/update_engine
rm -rf $BASE_DIR/system/bin/update_verifier
rm -rf $BASE_DIR/system/etc/init/recovery-persist.rc
rm -rf $BASE_DIR/system/etc/init/recovery-refresh.rc
rm -rf $BASE_DIR/system/etc/init/update_engine.rc
rm -rf $BASE_DIR/system/etc/init/update_verifier.rc
rm -rf $BASE_DIR/system/etc/init/cppreopts.rc
rm -rf $BASE_DIR/system/etc/init/otapreopt.rc

rm -rf $BASE_DIR/system/merge_config_*
rm -rf $system_ext/apex/com.android.vndk.v*

echo "==> Limpando oat e perf profiles..."
find "$BASE_DIR" -type d \( -name "app" -o -name "priv-app" \) | while read -r dir; do
    find "$dir" -type d -name "oat" -exec rm -rf {} + 2>/dev/null
    find "$dir" -type f -name "*.prof" -exec rm -f {} + 2>/dev/null
done

echo "==> Removendo fstab e verity..."
find "$BASE_DIR" -type f -name "fstab.*" -exec rm -f {} + 2>/dev/null
find "$BASE_DIR" -type f -name "verity_key" -exec rm -f {} + 2>/dev/null

echo "==> Script finalizado com sucesso."
