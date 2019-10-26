#!/usr/bin/env bash

set -e

shell_output() {
    echo -e "=================================================="
    echo -e "| $@"
    echo -e "=================================================="
}

get_file_hash() {
    local os="$1"
    local version="$2"
    local build="$3"

    local filename="flutter_${os}_${version}-${build}.zip"

    curl -L -o "$filename" "https://storage.googleapis.com/flutter_infra/releases/${build}/${os}/${filename}.zip"
    shasum -a 256 "$filename"
}

shell_output "Hashing Flutter:Latest for Mac OS"
get_file_hash "macos" "v1.9.1+hotfix.6" "stable"

shell_output "Hashing Flutter:Latest for Linux"
get_file_hash "linux" "v1.9.1+hotfix.6" "stable"
