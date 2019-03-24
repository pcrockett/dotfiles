#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

# Add soft links to files in this repo. If the destination file already exists,
# the user will be prompted with an (expected) error message, but the show will
# go on because of all the `|| true` bits at the end of the command.
ln -sv ~/dotfiles/git/.gitconfig ~/.gitconfig || true
ln -sv ~/dotfiles/bash/.profile ~/.profile || true
