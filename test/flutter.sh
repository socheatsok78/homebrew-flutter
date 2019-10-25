#!/usr/bin/env bash

set -e

shell_output() {
    echo -e "=================================================="
    echo -e "| $@"
    echo -e "=================================================="
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

shell_output "Switching to Dev Channel"
flutter channel dev

shell_output "Flutter is on Dev Channel"
flutter --version

shell_output "Switching to Beta Channel"
flutter channel beta

shell_output "Flutter is on Beta Channel"
flutter --version

shell_output "Switching to Master Channel"
flutter channel master

shell_output "Flutter is on Master Channel"
flutter --version
