#!/usr/bin/env bash

set -e

shell_output() {
    echo -e "=================================================="
    echo -e "| $@"
    echo -e "=================================================="
}

switch_flutter_channel() {
    local channel=$1
    shift

    shell_output "Switching to $channel channel"
    flutter channel $channel
    flutter --version

    shell_output "Flutter is on $channel channel"
    flutter --version
}

# Step 1
shell_output "Locating Flutter binary"
which flutter

# Step 2
shell_output "Checking installed Flutter version"
flutter --version

# Step 3
shell_output "Available Flutter Channels"
flutter channel

# Switch to Dev Channel
switch_flutter_channel "dev"

# Switch to Beta Channel
switch_flutter_channel "beta"

# Switch to Master Channel
switch_flutter_channel "master"
