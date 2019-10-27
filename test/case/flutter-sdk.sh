#!/usr/bin/env bash

set -e

shell_output() {
    echo -e "=================================================="
    echo -e "| $@"
    echo -e "=================================================="
}

sha256() {
    shasum --algorithm 256 "$1"
}

hash_files() {
    folder=$1
    for filename in "$folder"/*; do
        sha256 "$filename"
    done
}

download_flutter_sdk() {
    local os="$1"
    local filename="$2"
    local build=${3:-stable}

    mkdir -p "./sdk"

    local url="https://storage.googleapis.com/flutter_infra/releases/${build}/${os}/${filename}"

    shell_output "Downloading for flutter ${os}"
    echo -e "$url\n"

    curl -L \
        -o "./sdk/$filename" \
        $url
}

download_flutter_sdk "macos" "flutter_macos_v1.9.1+hotfix.6-stable.zip"
download_flutter_sdk "linux" "flutter_linux_v1.9.1+hotfix.6-stable.tar.xz"

shell_output "Generating hash for flutter ${os}"
hash_files "sdk"

shell_output "Listing Download Directory"
ls -lh "./sdk"
