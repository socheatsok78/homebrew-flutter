#!/usr/bin/env bash

set -e

source ./test/helper

# Flutter Stable
download_flutter_sdk "macos" "flutter_macos_v1.12.13+hotfix.5-stable.zip"
download_flutter_sdk "linux" "flutter_linux_v1.12.13+hotfix.5-stable.tar.xz"

# Flutter Beta
download_flutter_sdk "macos" "flutter_macos_v1.12.13+hotfix.6-beta.zip" "beta"
download_flutter_sdk "linux" "flutter_linux_v1.12.13+hotfix.6-beta.tar.xz" "beta"

shell_output "Generating hash for flutter ${os}"
hash_files "sdk"

shell_output "Listing Download Directory"
ls -lh "./sdk"
