#!/bin/bash

HOST_DIR=$1
BOARD_DIR=$2
IMAGES_DIR=$3

# ARM Trusted Firmware BL31
export BL31="${BINARIES_DIR}/bl31.bin"

# U-Boot version
UBOOT_VERSION=u-boot-2025.01-rc4

# Download U-Boot mainline
wget "https://ftp.denx.de/pub/u-boot/${UBOOT_VERSION}.tar.bz2"
tar xf $UBOOT_VERSION.tar.bz2
cd $UBOOT_VERSION

# Apply patches
PATCHES="${BR2_EXTERNAL_BATOCERA_PATH}/board/batocera/allwinner/h616/patches/uboot-2025.01/*.patch"
for patch in $PATCHES
do
echo "Applying patch: $patch"
patch -p1 < $patch
done

# Make config
make anbernic_rg35xx_h700_defconfig

# Build it
ARCH=aarch64 CROSS_COMPILE="${HOST_DIR}/bin/aarch64-buildroot-linux-gnu-" make -j$(nproc)
mkdir -p "${IMAGES_DIR}/batocera/uboot-anbernic-rg35xx"
cp u-boot-sunxi-with-spl.bin ../../uboot-anbernic-rg35xx/
