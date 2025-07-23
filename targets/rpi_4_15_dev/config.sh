#!/bin/bash

# Configuration for AOSP build for RPI4 device

export MANIFEST_URL="https://android.googlesource.com/platform/manifest"
export ADDITIONAL_STEP="curl -o .repo/local_manifests/manifest_brcm_rpi.xml -L https://raw.githubusercontent.com/raspberry-vanilla/android_local_manifest/android-15.0/manifest_brcm_rpi.xml --create-dirs"
export AOSP_BRANCH="android-15.0.0_r36"
export LUNCH_TARGET="aosp_rpi4-bp1a-userdebug"
export AOSP_DIR="/data/workareas2/projects/synthion/android-rpi"
# -j$(nproc)
export BUILD_COMMAND="source build/envsetup.sh && lunch $LUNCH_TARGET && make bootimage systemimage vendorimage -j4 && ./rpi4-mkimg.sh"
# . environment.sh && use_android rpi_4_15_dev
