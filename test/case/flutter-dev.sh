#!/usr/bin/env bash

set -e

source ./test/helper

install_flutter_cask

# Switch to Dev Channel
switch_flutter_channel "dev"

# Step 2
shell_output "Checking installed Flutter version"
flutter --version
