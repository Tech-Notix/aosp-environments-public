
# AOSP Build Environment

This repository contains scripts and environment setup for building multiple Android versions inside Docker containers, managing source sync, builds, and device configurations.

---

## Table of Contents

- [Environment Setup](#environment-setup)
- [Available Android Versions](#available-android-versions)
- [Using the Scripts](#using-the-scripts)
  - [`use_android` Function](#use_android-function)
  - [`download_aosp.sh`](#download_aospsh)
  - [`build_aosp.sh`](#build_aospsh)
  - [`build_docker.sh`](#build_dockersh)
- [Supporting New Devices](#supporting-new-devices)

---

## Environment Setup

1. **Source the environment script** to detect Android versions and enable helper functions:

    ```bash
    source environment.sh
    ```

2. The `environment.sh` script scans the `targets` directory inside the workspace for Android version folders (e.g., `android_15`, `android_14`).

3. **Select an Android version** with the `use_android` function:

    ```bash
    use_android android_15
    ```

    This will:
    - Set environment variables like `ACTIVE_ANDROID_VERSION`, `AOSP_DIR`, `DOCKER_IMAGE_NAME`, and more.
    - Source the version’s `config.sh` if present.
    - Prepare your environment for building and syncing that Android version.

---

## Available Android Versions

The environment scans the `targets` folder at the root of the workspace:

```
workspace/
└── targets/
    ├── emulator_13_dev
    ├── emulator_15_dev
    ├── rpi_4_15_dev
    ├── rpi_5_15_dev
    └── template #TBA
```

Each subdirectory corresponds to an Android version you can select with `use_android`.

---

## Using the Scripts

### `use_android`

Switches active Android version and sets necessary environment variables.

```bash
use_android <android_version>
```

Example:

```bash
use_android rpi_4_15_dev
```

### `download_aosp.sh`

Syncs and downloads AOSP source code for the selected Android version.

```bash
./download_aosp.sh
```

- Requires the environment to be sourced and a version selected.
- Uses `repo` tool with the branch specified in the selected version’s configuration.

---

### `build_aosp.sh`

Builds the selected Android version inside a Docker container.

```bash
./build_aosp.sh [manual]
```

- By default, runs an automatic build using the Docker container.
- Pass `manual` to start an interactive shell inside the container with the build command printed for manual invocation.

Example automatic build:

```bash
./build_aosp.sh
```

Example manual mode:

```bash
./build_aosp.sh manual
```

**Note:** The build uses the `LUNCH_TARGET` environment variable if set, or defaults to `aosp_x86_64-eng`.

---

### `build_docker.sh`

Builds the Docker image for the selected Android version.

```bash
./build_docker.sh
```

- Must be run after selecting the Android version with `use_android`.
- Uses the Dockerfile inside the selected version folder.

---


## Supporting New Devices

1. Make a duplicate template folder inside the targets directory.

2. Rename the directory to match it's purpo se  (e.g., `targets/android_<name>_<dev/release>`).

3. Update the `config.sh` with proper device specific paths and commands.

4. Update the `Dockerfile` with required packages.

---

## Tips

- Use tab completion with `use_android` to list available Android versions.
- Always run `download_aosp.sh` before building if sources are not already synced.
---

