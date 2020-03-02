#!/usr/bin/env bash

# This script is based on the template here:
#
#     https://gist.github.com/pcrockett/8e04641f8473081c3a93de744873f787
#
# Useful links when writing a script:
#
# Shellcheck: https://github.com/koalaman/shellcheck
# vscode-shellcheck: https://github.com/timonwong/vscode-shellcheck
# https://blog.yossarian.net/2020/01/23/Anybody-can-write-good-bash-with-a-little-effort
#

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

[[ "${BASH_VERSINFO[0]}" -lt 4 ]] && echo "Bash >= 4 required" && exit 1

# https://stackoverflow.com/a/1482133/138757
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

SSH_DIR=~/.ssh
if [ ! -d "$SSH_DIR" ]; then
    mkdir "$SSH_DIR"
fi

KEY_FILE="$SSH_DIR/id_ed25519"
if [ ! -f "$KEY_FILE" ]; then
    ssh-keygen -t ed25519 -a 100 -f "$KEY_FILE"
    echo ""
    echo "-----------------------------------------------------------"
    echo "New SSH key!"
    echo ""
    cat "$KEY_FILE.pub"
    echo ""
    echo "-----------------------------------------------------------"
    echo ""
fi

ln -sv "$SCRIPT_DIR/config" "$SSH_DIR/config" || true
