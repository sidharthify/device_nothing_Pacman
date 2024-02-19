#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/nothing/Pacman

# Asserts
TARGET_OTA_ASSERT_DEVICE := Pacman,PacmanEEA,PacmanIND,PacmanJPN

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    init_boot \
    odm \
    odm_dlkm \
    product \
    system \
    system_ext \
    system_dlkm  \
    vendor \
    vbmeta_vendor \
    vbmeta_system \
    vendor_boot \
    vendor_dlkm

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

IGNORE_PREFER32_ON_DEVICE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := Pacman
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 420

# Kernel
BOARD_BOOT_HEADER_VERSION := 4
BOARD_INIT_BOOT_HEADER_VERSION := 4

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

BOARD_KERNEL_BASE := 0x3fff8000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x26f08000
BOARD_KERNEL_TAGS_OFFSET := 0x07c88000
BOARD_DTB_OFFSET := 0x07c88000

BOARD_RAMDISK_USE_LZ4 := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true

BOARD_BOOTCONFIG += \
    androidboot.init_fatal_reboot_target=recovery

BOARD_KERNEL_CMDLINE := \
    bootopt=64S3,32N2,64N2

BOARD_MKBOOTIMG_ARGS += \
    --base $(BOARD_KERNEL_BASE) \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --pagesize $(BOARD_KERNEL_PAGESIZE) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) \
    --dtb_offset $(BOARD_DTB_OFFSET)

TARGET_NO_KERNEL_OVERRIDE := true
TARGET_KERNEL_SOURCE := $(DEVICE_PATH)-kernel/kernel-headers
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)-kernel/dtbo.img
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)-kernel/dtb

BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)-kernel/modules.load))
BOARD_VENDOR_KERNEL_MODULES := $(addprefix $(DEVICE-PATH)-kernel/kernel-modules/, $(notdir $(BOARD_VENDOR_KERNEL_MODULES_LOAD)))

BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)-kernel/modules.load.vendor_boot))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(addprefix $(DEVICE-PATH)-kernel/kernel-modules/, $(notdir $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)))

BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)-kernel/modules.load.recovery))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES := $(addprefix $(DEVICE-PATH)-kernel/kernel-modules/, $(notdir $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES += $(filter-out $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES),$(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES))

# Partitions
-include vendor/lineage/config/BoardConfigReservedSize.mk
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_USES_METADATA_PARTITION := true

BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864

BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := nothing_dynamic_partitions
BOARD_NOTHING_DYNAMIC_PARTITIONS_PARTITION_LIST := odm odm_dlkm product system system_dlkm system_ext vendor vendor_dlkm
BOARD_NOTHING_DYNAMIC_PARTITIONS_SIZE := 9122611200

BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
TARGET_USERIMAGES_SPARSE_F2FS_DISABLED := true

# Plaform
TARGET_BOARD_PLATFORM := mt6886

# Recovery
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init/fstab.mt6886
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
TARGET_USERIMAGES_USE_F2FS := true

# Inherit the proprietary files
include vendor/nothing/Pacman/BoardConfigVendor.mk
