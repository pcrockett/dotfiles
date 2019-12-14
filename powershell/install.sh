#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

THIS_DIR=`dirname "$(readlink -f "$0")"`

POWERSHELL_CONFIG_DIR=~/.config/powershell
if [ ! -d "$POWERSHELL_CONFIG_DIR" ]; then
  mkdir "$POWERSHELL_CONFIG_DIR"
fi

ln -sv "$THIS_DIR/profile.ps1" "$POWERSHELL_CONFIG_DIR/profile.ps1" || true
