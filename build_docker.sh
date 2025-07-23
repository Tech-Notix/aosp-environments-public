#!/bin/bash

#set -x

LOCAL_PATH="$(pwd)"

if [[ -z "$ACTIVE_AOSP_TARGET" ]]; then
    echo "\e[32mPlease run: source environment && use_android <version>\e[0m"
    return -1
fi

echo "Building Docker image for Android version: $ACTIVE_AOSP_TARGET"

if ! cd "$DOCKERFILE_DIR"; then
    echo "Error: DOCKERFILE_DIR '$DOCKERFILE_DIR' is not a valid directory."
    return -1
fi

echo "Building Docker image: $DOCKER_IMAGE_NAME"

docker build \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    -t "$DOCKER_IMAGE_NAME" "$DOCKERFILE_DIR" 2>&1 | tee -a "$LOGS_DIR/docker_build.log"
