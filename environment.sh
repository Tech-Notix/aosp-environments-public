#!/bin/bash

export LOCAL_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export TARGETS_DIR="$LOCAL_PATH/targets"
export AOSP_TARGETS=($(find "$TARGETS_DIR" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort))
export LOGS_DIR="$LOCAL_PATH/logs"

echo "Detected Android versions:"
for v in "${AOSP_TARGETS[@]}"; do
  echo -e "  - \e[32m$v\e[0m"
done

use_android() {
    local selected="$1"
    if [[ " ${AOSP_TARGETS[*]} " =~ " $selected " ]]; then

        # Source config.sh if exists
        local config_path="$TARGETS_DIR/$selected/config.sh"
        if [[ -f "$config_path" ]]; then
            source "$config_path"
        fi

        export DOCKER_IMAGE_NAME="${selected}-builder"
        export CONTAINER_NAME="${selected}-container"
        export DOCKERFILE_DIR="$TARGETS_DIR/$selected/docker"

        export ACTIVE_AOSP_TARGET="$selected"

        echo -e "Switched to: \e[32m$ACTIVE_AOSP_TARGET\e[0m"
    else
        echo -e "\e[31mInvalid version: $selected\e[0m"
        return 1
    fi
}

__register_use_android_completion() {
    local completion_script="$LOCAL_PATH/completions/use_android"
    if [[ -f "$completion_script" ]]; then
        source "$completion_script"
    fi
}
__register_use_android_completion

echo "Use: use_android <version> (TAB for autocompletion)"
