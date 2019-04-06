#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

REPO_DIR=`dirname "$(readlink -f "$0")"`

# Add soft links to files in this repo. If the destination file already exists,
# the user will be prompted with an (expected) error message, but the show will
# go on because of all the `|| true` bits at the end of the command.
ln -sv "$REPO_DIR/git/.gitconfig" ~/.gitconfig || true
ln -sv "$REPO_DIR/bash/.profile" ~/.profile || true
