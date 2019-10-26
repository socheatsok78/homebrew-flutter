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

    shell_output "Downloading for flutter ${os}"
    curl -L -o "$filename" "https://storage.googleapis.com/flutter_infra/releases/${build}/${os}/${filename}.zip"

    shell_output "Generating hash for flutter ${os}"
    shasum -a 256 "$filename"
}

get_file_hash "macos" "v1.9.1+hotfix.6" "stable"
get_file_hash "linux" "v1.9.1+hotfix.6" "stable"
