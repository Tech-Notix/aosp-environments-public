#!/bin/bash

# Configuration for AOSP 13 build for PC emulator
export MANIFEST_URL="https://android.googlesource.com/platform/manifest"
export ADDITIONAL_STEP=
export AOSP_BRANCH="android-13.0.0_r75"
export AOSP_DIR="/data/workareas2/projects/technotix/github/new/workareas/emulator_13_userdebug"
export LUNCH_TARGET="sdk_pc_x86_64-userdebug"
export BUILD_COMMAND="source build/envsetup.sh && lunch $LUNCH_TARGET && make -j$(nproc)"
# . environment.sh && use_android emulator_13_dev
