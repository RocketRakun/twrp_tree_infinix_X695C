FDEVICE="X695C"

fox_get_target_device() {
    if [[ "$BASH_SOURCE[0]" =~ "$FDEVICE" ]]; then
        FOX_BUILD_DEVICE="$FDEVICE"
    elif [[ "$1" == "$FDEVICE" ]]; then
        FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
    fox_get_target_device "$@"
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export TW_DEFAULT_LANGUAGE="en"
    export LC_ALL="C"
    export ALLOW_MISSING_DEPENDENCIES=true
    export FOX_BUILD_DEVICE="X695C"
    export TARGET_DEVICE_ALT="Infinix-X695C"

    # Partitions Recovery
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
    export FOX_RECOVERY_PRODUCT_PARTITION="/dev/block/mapper/product"
    export FOX_RECOVERY_SYSTEM_EXT_PARTITION="/dev/block/mapper/system_ext"
    export FOX_RECOVERY_SUPER_PARTITION="/dev/block/platform/bootdevice/by-name/super"
    export FOX_RECOVERY_BOOT_PARTITION="/dev/block/platform/bootdevice/by-name/boot"

    # A/B and Dynamic Partitions Support
    export FOX_AB_SUPPORT=true
    export OF_AB_DEVICE=1
    export OF_DYNAMIC_PARTITIONS=true
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
    export FOX_VIRTUAL_AB_DEVICE=1

    # OTA and Verity Support
    export OF_KEEP_DM_VERITY=1
    export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
    export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1

    # AVB Support
    export OF_PATCH_AVB20=1

    # Magisk Support
    export OF_USE_MAGISKBOOT=1
    export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1

    # Screen Height
    export OF_SCREEN_H=2400
    export OF_STATUS_H=80
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48
    export OF_ALLOW_DISABLE_NAVBAR=1

    # Backup and File System Support
    export OF_QUICK_BACKUP_LIST="/boot;/data;/system_image;/vendor_image;"
    export OF_USE_TAR_BINARY=1
    export OF_USE_SED_BINARY=1
    export OF_USE_XZ_UTILS=1

    # Additional Support 
    export FOX_DELETE_AROMAFM=1
    export FOX_ENABLE_APP_MANAGER=1
    export OF_DEFAULT_KEYMASTER_VERSION=4.0
    export FOX_EXTREME_SIZE_REDUCTION=1
    
    # R11.1 Settings
    export FOX_VERSION="R11.1_1"
    export FOX_BUILD_TYPE="Stable"
    export OF_MAINTAINER="RocketRakun"

    # Use LZMA
    export OF_USE_LZMA_COMPRESSION=1

    # Log Build Variables
    if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
        export | grep "FOX" >> "$FOX_BUILD_LOG_FILE"
        export | grep "OF_" >> "$FOX_BUILD_LOG_FILE"
        export | grep "TARGET_" >> "$FOX_BUILD_LOG_FILE"
        export | grep "TW_" >> "$FOX_BUILD_LOG_FILE"
    fi
fi
