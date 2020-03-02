#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

THISDIR=$(dirname "$(readlink -f "$0")")
USERDIR=~/.config/VSCodium/User

ln -sv "$THISDIR/settings.json" "$USERDIR/settings.json" || true
ln -sv "$THISDIR/keybindings.json" "$USERDIR/keybindings.json" || true

SNIPPETNAMES=$(basename -a $THISDIR/snippets/*.json)
for snippetname in $SNIPPETNAMES; do
    ln -sv "$THISDIR/snippets/$snippetname" "$USERDIR/snippets/$snippetname" || true
done
