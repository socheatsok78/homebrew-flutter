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
    flutter upgrade

    shell_output "Flutter is on $channel channel"
    flutter --version
}

uninstall_flutter() {
    shell_output "Homebrew zapping flutter"
    brew cask zap flutter

    shell_output "Homebrew untapping repositories"
    brew untap socheatsok78/flutter
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

# Uninstall & Untap
uninstall_flutter
