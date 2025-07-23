#!/bin/bash

#set -x

if [ ! -d "$AOSP_DIR" ]; then
    echo -e "\e[31mAOSP source directory not found at $AOSP_DIR. Run download_aosp.sh first.\e[0m"
    exit 1
fi

echo -e "\e[32mStarting AOSP build container: $CONTAINER_NAME\e[0m"
echo -e "\e[32mUsing lunch target: $LUNCH_TARGET\e[0m"

MODE="${1:-auto}"  # default to "auto" if no arg given

if [[ "$MODE" == "manual" ]]; then
    echo -e "\e[33mManual build mode enabled.\e[0m"
    echo "Starting interactive shell inside container..."
    docker run --rm -it \
        --name "$CONTAINER_NAME" \
        -v "$AOSP_DIR":/home/worker/aosp \
        -w /home/worker/aosp \
        "$DOCKER_IMAGE_NAME" \
        bash -c "echo 'Run this build command:'; echo \"$BUILD_COMMAND\"; exec bash"
else
    echo -e "\e[32mRunning automatic build...\e[0m"
    docker run --rm -it \
        --name "$CONTAINER_NAME" \
        -v "$AOSP_DIR":/home/worker/aosp \
        -w /home/worker/aosp \
        "$DOCKER_IMAGE_NAME" \
        bash -c "$BUILD_COMMAND"
fi
