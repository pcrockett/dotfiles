#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

REPO_DIR=`dirname "$(readlink -f "$0")"`

# Add soft links to files in this repo. If the destination file already exists,
# the user will be prompted with an (expected) error message, but the show will
# go on because of all the `|| true` bits at the end of the command.
ln -sv "$REPO_DIR/git/.gitconfig" ~/.gitconfig || true

GPG_DIR=~/.gnupg
if [ ! -d "$GPG_DIR" ]; then
  mkdir "$GPG_DIR"
fi

ln -sv "$REPO_DIR/gpg/gpg.conf" "$GPG_DIR/gpg.conf" || true
ln -sv "$REPO_DIR/gpg/dirmngr.conf" "$GPG_DIR/dirmngr.conf" || true

if [ ! -v INTERACTIVE_PROFILE_LOADED ]; then
    echo "" >> ~/.bashrc
    echo ". $REPO_DIR/bash/interactive-profile.sh >> /dev/null" >> ~/.bashrc
    echo "Set up interactive profile in .bashrc. DO NOT run this install script again without restarting the shell first."
fi
