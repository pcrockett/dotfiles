#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

THISDIR=$(dirname "$(readlink -f "$0")")
CODIUM_USER_DIR=~/.config/VSCodium/User
CODIUM_SNIPPETS_DIR="$CODIUM_USER_DIR/snippets"

mkdir --parents "$CODIUM_SNIPPETS_DIR"

ln --symbolic --verbose "$THISDIR/settings.json" "$CODIUM_USER_DIR/settings.json" || true
ln --symbolic --verbose "$THISDIR/keybindings.json" "$CODIUM_USER_DIR/keybindings.json" || true

SNIPPETNAMES=$(basename -a $THISDIR/snippets/*.json)
for snippetname in $SNIPPETNAMES; do
    ln --symbolic --verbose "$THISDIR/snippets/$snippetname" "$CODIUM_SNIPPETS_DIR/$snippetname" || true
done

OSS_USER_DIR=~/.config/Code\ -\ OSS/User
ln --symbolic --verbose "${CODIUM_USER_DIR}" "${OSS_USER_DIR}" || true
