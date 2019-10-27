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

get_file_hash() {
    local os="$1"
    local filename="$2"
    local build=${3:-stable}

    mkdir -p "./download"

    local url="https://storage.googleapis.com/flutter_infra/releases/${build}/${os}/${filename}"

    shell_output "Downloading for flutter ${os}"
    echo -e "$url\n"
    curl -L \
        -o "./download/$filename" \
        $url

    shell_output "Generating hash for flutter ${os}"
    sha256 "./download/$filename"

    shell_output "Listing Download Directory"
    ls -lh
}

get_file_hash "macos" "flutter_macos_v1.9.1+hotfix.6-stable.zip"
get_file_hash "linux" "flutter_linux_v1.9.1+hotfix.6-stable.tar.xz"
