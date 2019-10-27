#!/usr/bin/env bash

set -e

source ./test/helper

download_flutter_sdk "macos" "flutter_macos_v1.9.1+hotfix.6-stable.zip"
download_flutter_sdk "linux" "flutter_linux_v1.9.1+hotfix.6-stable.tar.xz"

shell_output "Generating hash for flutter ${os}"
hash_files "sdk"

shell_output "Listing Download Directory"
ls -lh "./sdk"
