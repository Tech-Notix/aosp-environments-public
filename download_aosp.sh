#!/bin/bash

#set -x

if [[ -z "$ACTIVE_AOSP_TARGET" || -z "$AOSP_DIR" || -z "$AOSP_BRANCH" ]]; then
  echo -e "\e[31mError: Please source the environment and run use_android <version> first.\e[0m"
  return -1
fi

echo -e "\e[32mStarting AOSP download for $ACTIVE_AOSP_TARGET ($AOSP_BRANCH)...\e[0m"

mkdir -p "$AOSP_DIR"
cd "$AOSP_DIR" || { echo -e "\e[31mFailed to enter directory $AOSP_DIR\e[0m"; return -1; }

echo "Manifest url:$MANIFEST_URL"
echo "Aosp branch:$AOSP_BRANCH"

if [ ! -d .repo ]; then
  repo init -u "$MANIFEST_URL" -b "$AOSP_BRANCH"
  if [[ -n "$ADDITIONAL_STEP" ]]; then
    echo "Running ADDITIONAL_STEP: $ADDITIONAL_STEP"
    eval "$ADDITIONAL_STEP"
  fi
else
  echo "Repo already initialized."
fi

# Sync the repo with parallel jobs (adjust -jN as needed), default j is 4
# -j$(nproc) --fail-fast
repo sync 2>&1 | tee -a "$LOGS_DIR/repo_sync.log"

echo -e "\e[32mAOSP download completed for $ACTIVE_AOSP_TARGET.\e[0m"
