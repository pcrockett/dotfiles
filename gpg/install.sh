#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

THIS_DIR=`dirname "$(readlink -f "$0")"`

GPG_DIR=~/.gnupg
if [ ! -d "$GPG_DIR" ]; then
  mkdir "$GPG_DIR"
fi

ln -sv "$THIS_DIR/gpg.conf" "$GPG_DIR/gpg.conf" || true
ln -sv "$THIS_DIR/dirmngr.conf" "$GPG_DIR/dirmngr.conf" || true
