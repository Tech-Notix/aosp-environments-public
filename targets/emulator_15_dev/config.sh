#!/bin/bash

# Configuration for AOSP 15 build for PC emulator

export MANIFEST_URL="https://android.googlesource.com/platform/manifest"
export ADDITIONAL_STEP=
export AOSP_BRANCH="android-15.0.0_r36"
export AOSP_DIR="/data/workareas2/projects/technotix/github/new/workareas/emulator_15_userdebug"
export LUNCH_TARGET="aosp_cf_x86_64_pc-trunk_staging-userdebug"
export BUILD_COMMAND="source build/envsetup.sh && lunch $LUNCH_TARGET && make -j$(nproc)"
# . environment.sh && use_android emulator_15_dev
